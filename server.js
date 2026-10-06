const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 5173;
const MIME = {
  '.html': 'text/html; charset=UTF-8',
  '.css': 'text/css; charset=UTF-8',
  '.js': 'application/javascript; charset=UTF-8',
  '.svg': 'image/svg+xml',
  '.json': 'application/json',
  '.webmanifest': 'application/manifest+json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.ico': 'image/x-icon',
  '.woff2': 'font/woff2',
  '.woff': 'font/woff',
  '.ttf': 'font/ttf'
};

const server = http.createServer((req, res) => {
  let safePath = path.normalize(decodeURI(req.url.split('?')[0]));
  if (safePath === '/' || safePath === '\\') safePath = '/index.html';
  const filePath = path.join(__dirname, safePath);

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('Not Found');
      return;
    }
    const ext = path.extname(filePath).toLowerCase();
    const headers = { 'Content-Type': MIME[ext] || 'application/octet-stream' };
    if (path.basename(filePath) === 'sw.js') {
      headers['Service-Worker-Allowed'] = '/';
      headers['Cache-Control'] = 'no-cache, no-store, must-revalidate';
    }
    res.writeHead(200, headers);
    res.end(data);
  });
});

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
