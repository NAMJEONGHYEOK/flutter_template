const express = require('express');
const mariadb = require('mariadb');
const jwtutil = require('./jwtutil');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser'); // body-parser 모듈 불러오기
const cors = require('cors');
const config = require ('./config');




// JWT Secret Key 설정
const accessTokenSecret = config.accessTokenSecret;
const refreshTokenSecret = config.refreshTokenSecret;
const app = express();



app.use(cookieParser());
app.use(cors());
// const whitelist = ['http://localhost:3000/', 'http://localhost:3000/login','http://localhost:3000/#','http://localhost:3000/#/',];
// const corsOptions = {
//   origin: function (origin, callback) {
//     if (whitelist.indexOf(origin) !== -1) {
//       callback(null, true);
//     } else {
//       callback(new Error('Not allowed by CORS'));
//     }
//   }
// };
// app.use(cors(corsOptions));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// MariaDB 연결 설정
const pool = mariadb.createPool({
  host: config.db.host,
  user: config.db.user,
  password: config.db.password,
  database: config.db.database,
  connectionLimit: 10,
});

//토큰 검증 미들웨어
const authMiddleware = async (req, res,conn) => {
 
  const accessToken = req.body['access_token']
  const refreshToken = req.body['refresh_token']
  if (!accessToken) {
    return res.status(401).send('go login');
  }
  try {
    // Access Token 검증 
    await jwtutil.authenticateToken(accessToken)
    .then(decoded => {
      req.user = decoded;
  

      return res.status(200).send({accessToken,refreshToken}) //  access 정상인경우 200, 토큰 전송
    })
    .catch(async err => {
      if (err.name === 'TokenExpiredError')  {
        // Access Token 만료 시, Refresh Token 검증 수행
        try {
          const decoded = await jwtutil.verifyRefreshToken(refreshToken);
          req.user = { id: decoded.id };
          // access 토큰만 만료, refresh 는 남았을 경우 둘다 재발급 필요
          return await jwtutil.generateTokenAndSave(req,res,conn,req.user)
          
        } catch (err) {
          //refresh 토큰 만료시 로그인 해야함
          if (err.name === 'TokenExpiredError') {
            
           return res.status(401).send('token 유효기간 만료')
          } else {
            console.error(err);
          }
        }
      } else {
        console.log(err);
        return res.status(401).send('Unauthorized Access3');
      }
    });
    

  } catch (err) {
    console.error(err);
   
  }

};


// app.use(authMiddleware);


// 토큰 로그인 라우터
app.post('/token_login' ,async (req, res) => {
  const { access_token, refresh_token } = req.body;

  // MariaDB에서 유저 정보 조회
  let conn;
  conn = await pool.getConnection();

  try {

      authMiddleware(req,res,conn);

  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  } finally {
    if (conn) conn.release();
  }
});

// 로그인 라우터
app.post('/login', async (req, res) => {
  const { id, password } = req.body;

  // MariaDB에서 유저 정보 조회
  let conn;
  try {

    if (!id) {
      return res.status(400).send('id is required');
    }
    conn = await pool.getConnection();
    const result = await conn.query(`SELECT * FROM user WHERE id = '${id}' and password ='${password}'`);
    if (result.length === 0) {
      return res.status(400).send('Invalid ID or password');
    }
    const user = result[0];
    await jwtutil.generateTokenAndSave(req,res,conn,user);
  
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  } finally {
    if (conn) conn.release();
  }
});

// 로그아웃 라우터
app.delete('/logout', async (req, res) => {
  const refreshToken = req.body;
  // Refresh Token 삭제 (MariaDB)
  console.log(refreshToken);
  console.log(refreshToken.token);
  
  let conn;
  try {
    conn = await pool.getConnection();
    await conn.query(`DELETE FROM refresh_tokens WHERE token = '${refreshToken}'`);
    res.sendStatus(204);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  } finally {
    if (conn) conn.release();
  }
});


app.get('/', (req, res) => {
  res.send('Hello, World!');
});


// 서버 시작
app.listen(3000, () => {
  console.log('Server started on port 3000');
});