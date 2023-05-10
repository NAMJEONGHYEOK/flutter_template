// const jwt = require('jsonwebtoken');
// const config = require('./config');

// // Access Token 생성 함수
// function generateAccessToken(user) {
//   const accessToken = jwt.sign(user, config.accessTokenSecret, { expiresIn: '30m' });
//   return accessToken;
// }

// // Refresh Token 생성 함수
// function generateRefreshToken(user) {
//   const refreshToken = jwt.sign(user, config.refreshTokenSecret, { expiresIn: '1d' });
//   return refreshToken;
// }

// // Access Token 검증 미들웨어
// function authenticateToken(req, res, next) {
//   const authHeader = req.headers['authorization'];
//   const token = authHeader && authHeader.split(' ')[1];

//   if (token == null) {
//     return res.sendStatus(401);
//   }

//   jwt.verify(token, config.accessTokenSecret, (err, user) => {
//     if (err) {
//       return res.sendStatus(403);
//     }
//     req.user = user;
//     next();
//   });
// }

// // Refresh Token 검증 함수
// function verifyRefreshToken(token) {
//   try {
//     const decoded = jwt.verify(token, config.refreshTokenSecret);
//     return decoded;
//   } catch (err) {
//     return null;
//   }
// }

// module.exports = {
//   generateAccessToken,
//   generateRefreshToken,
//   authenticateToken,
//   verifyRefreshToken
// };