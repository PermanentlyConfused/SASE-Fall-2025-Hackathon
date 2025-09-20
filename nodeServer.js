const { Pool } = require("pg");
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "home_db",
  password: "Mlpnkobji123",
  port: 5432,
});

const dns = require("node:dns");
const os = require("node:os");

const options = { family: 4 };

const port = 8080;
const app = express();
app.use(cors());

app.get(`/events`, async (req, res) => {
  try {
    const QueryRes = await pool.query("SELECT * FROM Events");
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        console.log(row);
        payload.push({
          Category: row.category,
          Description: row.description,
          Address: row.address,
          Lat: row.lat,
          Long: row.long,
        });
      }
      console.log(payload);
      res.status(200).json({ payload });
    } else {
      res.status(401).json({ message: "Invalid req" });
    }
  } catch (err) {
    console.log(err.message);
    res.status(500).json({ message: "Error: ", error: err.message });
  }
});

app.listen(port, () => {
  dns.lookup(os.hostname(), options, (err, addr) => {
    if (err) {
      console.error(err);
    } else {
      console.log(`Server listening-- IPv4 address: ${addr}:${port}`);
    }
  });
});
