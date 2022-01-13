const express = require('express');
const cors = require('cors')

const app = express();

app.use(express.json());
app.use(cors())



const port = 4500;
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});