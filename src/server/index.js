const express = require('express');
const githubFile = path.join(__dirname, '..', (process.node.GITHUB_FILE || 'server/github.json'));
const githubConfig = require(githubFile);
const githubMiddleware = require('github-webhook-middleware')({
  secret: githubConfig.organization.secret,
});

const port = process.env.PORT || 4657;
const app = express();

app.post('/hooks/github/', githubMiddleware, (req, res) => {
  console.log(req.headers['x-github-event']);
  if (req.headers['x-github-event'] !== 'issue') {
    return res.status(200)
      .end();
  }

  const payload = req.body;
  console.log(payload);
});

app.listen(port, () => {
  console.log(`Listening on port ${port}.`);
});
