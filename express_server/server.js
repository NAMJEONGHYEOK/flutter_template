const express = require('express');
const bodyParser = require('body-parser');
const config = require('./config'); // config.js 파일 불러오기

const app = express();
const port = config.server.port; // 포트 설정

app.use(bodyParser.json());

// 라우팅 설정
app.use('/', require('./routes'));

// 서버 실행
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
