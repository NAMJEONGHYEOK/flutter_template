const jwt = require('jsonwebtoken');
const moment = require('moment-timezone');
const config = require('./config');

// Access Token 생성 함수 access 토큰 유효시간 설정 
function generateAccessToken(user) {
  const accessToken = jwt.sign(user, config.accessTokenSecret, { expiresIn: '30m' });
  return accessToken;
}

// Refresh Token 생성 함수 refresh 토큰 유효시간 설정
function generateRefreshToken(user) {
  const refreshToken = jwt.sign(user, config.refreshTokenSecret, { expiresIn: '1h' });
  return refreshToken;
}

function authenticateToken(token) {
  if (token == null) {
    return Promise.reject(new Error('Access token not found')); // 에러 처리 후 반환
  }
  return new Promise((resolve, reject) => {
    jwt.verify(token, config.accessTokenSecret, (err, decoded) => {
      if (err) {
        reject(err); // 에러 처리 후 반환
      } else {
        resolve(decoded); // 성공적으로 검증된 토큰 반환
      }
    });
  });
}

// Refresh Token 검증 함수
function verifyRefreshToken(token) {
  return new Promise((resolve, reject) => {
    try {
      const decoded = jwt.verify(token, config.refreshTokenSecret);
      resolve(decoded);
    } catch (err) {
      reject(err);
    }
  });
}


 const generateTokenAndSave = async (req, res,conn,user ) => {
  
    // refresh 토큰 유효시간 지정 (1분)
    const formattedExpiresAt = moment().tz('Asia/Seoul').add(1, 'hours').format('YYYY-MM-DD HH:mm:ss');
  
    // Access Token, Refresh Token 생성
    const accessToken = generateAccessToken({ id: user.id });
    const refreshToken = generateRefreshToken({ id: user.id });
  
    try {
      // 기존 토큰 삭제
      const result = await conn.query(`DELETE FROM refresh_tokens WHERE user_id = '${user.id}'`);
    
      // 기존 토큰 삭제 후 num 값 순차적으로 변경
      await conn.query(`SET @num := 0`);
      await conn.query(`UPDATE refresh_tokens SET num = @num := @num + 1 WHERE user_id = '${user.id}' ORDER BY created_at`);
      
      // AUTO_INCREMENT 값 변경
      const maxNumResult = await conn.query(`SELECT MAX(num) as max_num FROM refresh_tokens`);
      const maxNum = maxNumResult[0].max_num || 0;
      await conn.query(`ALTER TABLE refresh_tokens AUTO_INCREMENT = ${maxNum + 1}`);
      
      // 새로운 토큰 삽입
      await conn.query(`INSERT INTO refresh_tokens (user_id, token, expires_at) VALUES ('${user.id}', '${refreshToken}', '${formattedExpiresAt}')`);
    } catch (err) {
      console.error(err);
    }
    

    // Response Header에 저장
    res.set('Access-Control-Allow-Origin','*')
    res.set('Access-Control-Allow-Credentials', 'true');
    res.send({ accessToken,refreshToken });

  };

module.exports = {
  generateAccessToken,
  generateRefreshToken,
  authenticateToken,
  verifyRefreshToken,
  generateTokenAndSave,

};