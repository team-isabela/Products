const { Pool } = require('pg');
const token = require('../config');

const pool = new Pool({
  host: '54.227.69.74',
  port: 5432,
  user: 'salarmalik',
  password: 'password',
  database: 'products',
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
});

pool.connect(err => {
  if (err) {
    console.error('connection error', err.stack)
  } else {
    console.log('connected')
  }
})

module.exports = pool;

