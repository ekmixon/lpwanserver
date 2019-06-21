// Main application, loaded from bin/rest
//
// This module handles translating REST requests to the methods that handle
// those operations.  This module also manages the login sessions and
// permissions required to execute the various operations.

const config = require('./rest/config')
var express = require('express')
var cors = require('cors')
// var path = require('path');
var cookieParser = require('cookie-parser')
// server
var RestServer = require('./rest/restServer')
var appLogger = require('./rest/lib/appLogger')
const serveSpa = require('./rest/lib/serve-spa')
const { normalizeFilePath } = require('./rest/lib/utils')

/**
 * Event listener for HTTP server "error" event.
 */

function onError (error) {
  if (error.syscall !== 'listen') {
    throw error
  }

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(config.get('port') + ' requires elevated privileges')
      process.exit(1)
    case 'EADDRINUSE':
      console.error(config.get('port') + ' is already in use')
      process.exit(1)
    default:
      throw error
  }
}

// Add the cors manager
var whitelistStr = config.get('cors_whitelist')
var whitelistRegExp = []
for (var i = 0; i < whitelistStr.length; ++i) {
  whitelistRegExp[ i ] = new RegExp(whitelistStr[ i ])
}
var corsOptions = {
  origin: function (origin, callback) {
    // Walk the list of regular expressions.
    for (var i = 0; i < whitelistRegExp.length; ++i) {
      // If we match, we're good.
      if (whitelistRegExp[ i ].test(origin)) {
        callback(null, true)
        return
      }
    }
    callback(new Error('Not allowed by CORS settings'))
  }
}

module.exports = async function createApp () {
  // Create the REST application.
  var app = express()

  if (config.get('public_dir')) {
    serveSpa({
      app,
      public: normalizeFilePath(config.get('public_dir')),
      omit: req => /^\/api/.test(req.path)
    })
  }

  app.on('error', onError)

  // Add a logger if enabled.
  appLogger.initRESTCallLogger(app)

  // Add the body parser.
  app.use(express.json())

  // Add a cookie parser.
  app.use(cookieParser())

  app.use(cors(corsOptions))

  // Initialize the application support interfaces.  We pass in the
  // application so we can add functions and API endpoints.
  var restServer = new RestServer(app)
  await restServer.initialize()

  return app
}
