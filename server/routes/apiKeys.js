const express = require('express');

const apiKeysRoutes = express.Router();

apiKeysRoutes.get('/ipfs', (_, res) => {
  res.json({ key: process.env.REACT_APP_IPFS_API_KEY });
});

module.exports = apiKeysRoutes;
