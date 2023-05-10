const express = require('express');
const mariadb = require('mariadb');
const moment = require('moment-timezone');
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser'); // body-parser 모듈 불러오기
const cors = require('cors');
const config = require ('./config');

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

// JWT Secret Key 설정
const accessTokenSecret = config.accessTokenSecret;
const refreshTokenSecret = config.refreshTokenSecret;


// Access Token 발급 함수
function generateAccessToken(user) {
  return jwt.sign(user, accessTokenSecret, { expiresIn: '1h' });
}

// Refresh Token 발급 함수
function generateRefreshToken(user) {
  return jwt.sign(user, refreshTokenSecret, {expiresIn: '36h'});
}

// Access Token 검증 미들웨어
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (token == null) {
    return res.sendStatus(401);
  }

  jwt.verify(token, accessTokenSecret, (err, user) => {
    if (err) {
      return res.sendStatus(403);
    }
    req.user = user;
    next();
  });
}

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

    // 비밀번호 검증 해쉬값은 나중에 작업...

    // const isPasswordMatch = await bcrypt.compare(password, user.password);
    // if (!isPasswordMatch) {
    //   return res.status(400).send('Invalid ID or password');
    // }

    // Access Token, Refresh Token 생성
      // refresh토큰 유효시간 지정
      const formattedExpiresAt = moment().tz('Asia/Seoul').add(10, 'minutes').format('YYYY-MM-DD HH:mm:ss');

    const accessToken = generateAccessToken({ id: user.id });
    const refreshToken = generateRefreshToken({ id: user.id });

    // Refresh Token 저장 (MariaDB)
    await conn.query(`INSERT INTO refresh_tokens (user_id, token, expires_at) VALUES ('${user.id}', '${refreshToken}', '${formattedExpiresAt}')`);
    // Access Token을 Response Header에 저장
    res.header('Access-Control-Allow-Origin', '*');
    res.set('Authorization', `Bearer ${accessToken}`);
    res.cookie('refreshToken', refreshToken, { httpOnly: true, secure: true });
    res.send({ accessToken });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  } finally {
    if (conn) conn.release();
  }
});

// 로그아웃 라우터
app.delete('/logout', async (req, res) => {
  const refreshToken = req.body.token;

  // Refresh Token 삭제 (MariaDB)
  let conn;
  try {
    conn = await pool.getConnection();
    await conn.query(`DELETE FROM RefreshToken WHERE token = '${refreshToken}'`);
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