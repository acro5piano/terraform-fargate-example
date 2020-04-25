require('http')
  .createServer((req, res) => {
    console.log(req.url)
    res.end('ok')
  })
  .listen(3000, () => {
    console.log('listen to http://0.0.0.0:3000')
  })
