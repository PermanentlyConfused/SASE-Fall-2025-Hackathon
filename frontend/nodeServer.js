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

const port = 8081;
const app = express();
app.use(cors());
app.use(express.json());

app.get(`/events`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT DISTINCT e.* FROM Events e JOIN Hobby_Events he ON he.EventID = e.EventID JOIN (SELECT hp.*,unnest(string_to_array(hp.Hobbies, ','))::INT AS HobbyID FROM HomeProfile hp JOIN SelectedProfile sp ON hp.HomeID = sp.HomeID) parsed_hobbies ON parsed_hobbies.HobbyID = he.HobbyID WHERE  ABS(e.Lat - parsed_hobbies.Lat) <= 0.5 AND ABS(e.Long - parsed_hobbies.Long) <= 0.5;"
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
          StartDate: row.startdate,
        });
      }
    }
    //   console.log(payload);

    const SecondRes = await pool.query(
      "SELECT * FROM Events WHERE Category <> 'Events';"
    );
    if (SecondRes.rows.length > 0) {
      for (const row of SecondRes.rows) {
        // console.log(row);
        payload.push({
          Category: row.category,
          Description: row.description,
          Address: row.address,
          Lat: row.lat,
          Long: row.long,
        });
      }
      res.status(200).json({ payload });
    } else {
      res.status(401).json({ message: "Invalid req" });
    }
  } catch (err) {
    console.log(err.message);
    res.status(500).json({ message: "Error: ", error: err.message });
  }
});

app.get(`/getRandomEvents`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      `SELECT DISTINCT e.* 
       FROM Events e 
       JOIN Hobby_Events he ON he.EventID = e.EventID 
       JOIN (
         SELECT hp.*, unnest(string_to_array(hp.Hobbies, ','))::INT AS HobbyID 
         FROM HomeProfile hp 
         JOIN SelectedProfile sp ON hp.HomeID = sp.HomeID
       ) parsed_hobbies ON parsed_hobbies.HobbyID = he.HobbyID 
       WHERE ABS(e.Lat - parsed_hobbies.Lat) <= 0.5 
         AND ABS(e.Long - parsed_hobbies.Long) <= 0.5;`
    );

    if (QueryRes.rows.length > 0) {
      const randomIndex = Math.floor(Math.random() * QueryRes.rows.length);
      const row = QueryRes.rows[randomIndex];

      const payload = {
        Description: row.description,
        Address: row.address,
        StartDate: row.startdate,
      };

      res.status(200).json({ payload });
    } else {
      res.status(404).json({ message: "No events found" });
    }
  } catch (err) {
    console.error(err.message);
    res
      .status(500)
      .json({ message: "Internal server error", error: err.message });
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

app.get(`/getSavedHobbies`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT hobbies FROM HomeProfile WHERE HomeID = (SELECT HomeID FROM SelectedProfile LIMIT 1);"
    );
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        console.log(row);
        payload.push({
          hobbiesString: row.hobbies,
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

app.get(`/getElectric`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT u.Company, u.PhoneNumber FROM Utilities u, HomeProfile h, SelectedProfile s, HomeProfile_Utilities hu WHERE s.HomeID = h.HomeID AND h.HomeID = hu.HomeID AND hu.UtilID = u.UtilID and u.UtilityType = 'electric';"
    );
    if (QueryRes.rows.length > 0) {
      var payload = [];

      for (const row of QueryRes.rows) {
        console.log(row);
        payload.push({
          utilityname: row.company,
          utilityphone: row.phonenumber,
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

app.get(`/getGas`, async (req, res) => {
  try {
    const QueryRes = await pool.query(
      "SELECT u.Company, u.PhoneNumber FROM Utilities u, HomeProfile h, SelectedProfile s, HomeProfile_Utilities hu WHERE s.HomeID = h.HomeID AND h.HomeID = hu.HomeID AND hu.UtilID = u.UtilID and u.UtilityType = 'gas';"
    );
    if (QueryRes.rows.length > 0) {
      var payload = [];
      for (const row of QueryRes.rows) {
        // console.log(row);
        payload.push({
          utilityname: row.company,
          utilityphone: row.phonenumber,
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
