const { Pool } = require("pg");
const express = require("express");
const cors = require("cors");

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
app.use(express.json());

app.get(`/events`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT e.* FROM Events e JOIN SelectedProfile sp ON TRUE JOIN HomeProfile hp ON hp.HomeID = sp.HomeID WHERE ABS(e.Lat - hp.Lat) <= 0.5 AND ABS(e.Long - hp.Long) <= 0.5;"
    );
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        // console.log(row);
        payload.push({
          Category: row.category,
          Description: row.description,
          Address: row.address,
          Lat: row.lat,
          Long: row.long,
        });
      }
      //   console.log(payload);
      res.status(200).json({ payload });
    } else {
      res.status(401).json({ message: "Invalid req" });
    }
  } catch (err) {
    console.log(err.message);
    res.status(500).json({ message: "Error: ", error: err.message });
  }
});

app.get(`/getHobbies`, async (req, res) => {
  try {
    const QueryRes = await pool.query("SELECT * FROM Hobbies");
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        // console.log(row);
        payload.push({
          hobbyid: row.hobbyid,
          hobbyname: row.hobbyname,
        });
      }
      // console.log(payload);
      res.status(200).json({ payload });
    } else {
      res.status(401).json({ message: "Invalid req" });
    }
  } catch (err) {
    console.log(err.message);
    res.status(500).json({ message: "Error: ", error: err.message });
  }
});

app.post(`/saveHobbies`, async (req, res) => {
  try {
    const { hobbies } = req.body;
    const hobbiesString = hobbies.join(", ");
    // console.log(hobbiesString);
    const QueryRes = await pool.query(
      `UPDATE HomeProfile SET Hobbies = '${hobbiesString}' WHERE HomeID = (SELECT HomeID FROM SelectedProfile LIMIT 1);`
    );

    res.status(200).json({});
  } catch (err) {
    console.log(err.message);
    res.status(500).json({ message: "Error: ", error: err.message });
  }
});

app.get(`/currentloc`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT hp.Lat, hp.Long FROM SelectedProfile sp JOIN HomeProfile hp ON sp.HomeID = hp.HomeID LIMIT 1;"
    );
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        // console.log(row);
        payload.push({
          Lat: row.lat,
          Long: row.long,
        });
      }
      //   console.log(payload);
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
