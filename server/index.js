const express = require('express');

const app = express();

app.use(express.json());



const port = 4500;
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});