// Use coffee script when the app starts up
require('coffee-script');

/**
 * Module dependencies.
 */

var express = require('express'), 
    RedisStore = require('connect-redis')(express),
    http = require('http'), 
    mongoose = require('mongoose'),
    path = require('path');

// connect to Mongo when the app initializes
mongoose.connect('mongodb://localhost/users');
var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session({
    store: new RedisStore
  }));
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

// Routes
require('./apps/auth/routes')(app);

server = app.listen(app.settings.port);
console.log("Express server listening on port %d in %s mode", app.settings.port, app.settings.env);

