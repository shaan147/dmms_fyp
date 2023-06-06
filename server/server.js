const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON data in the request body
// Create a MySQL connection
const connection = mysql.createConnection({
  host: "localhost",
  user: "admin",
  password: "",
  database: "med"
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error("Error connecting to the database:", err);
  } else {
    console.log("Connected to the database");
  }
});

// Define a route to handle the drug search
app.get("/drugs/:rxcui", (req, res) => {
  const rxcui = req.params.rxcui;

  // Construct the SQL query
  const query = `SELECT STR FROM rxnconso WHERE RXCUI = '${rxcui}'`;

  // Execute the query
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).json({ error: "Internal server error" });
    } else {
      if (results.length > 0) {
        const drug = results[0];
        res.json({ STR: drug.STR });
      } else {
        res.json({ STR: "" }); // Drug not found
      }
    }
  });
});

// Define a route to handle storing the RXCUI in the database
app.post("/api/storeRxcui", (req, res) => {
  const rxcui = req.body.rxcui;
  console.log('Received RXCUI:', rxcui);
  // Construct the SQL query with the correct table and column names
  const query = `INSERT INTO drug_info (rxcui) VALUES ('${rxcui}')`;

  // Execute the query
  connection.query(query, (err, result) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).json({ error: "Internal server error", details: err.message });
    } else {
      res.sendStatus(200); // Successful insertion
    }
  });
});

// Start the server
const port = 8081;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
