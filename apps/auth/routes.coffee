module.exports = (app) ->
  
  app.get "/", (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Home"
      
  app.post "/sessions", (req, res) ->
    console.log "Username: #{req.body.username}, Password: #{req.body.password}"
    if 'test' is req.body.username and "test2" is req.body.password
      req.session.user = req.body.username
      res.redirect "/users/#{req.body.username}"
      return
    else
      res.redirect "/"
      
  app.del "/sessions", (req, res) ->
    console.log "Deleting user session", req.xhr
    req.session.regenerate (err) ->
      res.send(200)
    
  app.get "/signup", (req, res) ->
    console.log "Showing the signup form"
    res.render "#{__dirname}/views/signup",
      title: "SignUp"
      
  app.post "/users", (req, res) ->
    console.log " Signing Up A New User", req.body
    # Install MongoDB and Mongoose
    res.redirect "/"
    
  app.get "/users/:user", (req, res) ->
    unless req.session.user
      res.redirect "/"
      return
      
    res.render "#{__dirname}/views/account",
      user: req.session.user
      email: "sample@email.com"
      title: req.session.user