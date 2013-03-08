mongoose = require('mongoose')

UserSchema = new mongoose.Schema
  username: String
  password: String
  email: String
  birthday: Date
  
module.exports = mongoose.model "User", UserSchema