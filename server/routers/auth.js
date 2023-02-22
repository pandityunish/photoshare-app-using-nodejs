const express = require("express");
const User = require("../models/Usermode");
const bcrypt = require("bcryptjs");

const authrouter = express.Router();

authrouter.post("/auth/createuser", async (req, res) => {
  try {
    const { name, email, image, password } = req.body;
    let existuser = await User.findOne({ email });
    if (existuser) {
      res.json({ mes: "This email is not available" });
    } else {
      const salt = await bcrypt.genSalt(10);
      const secPass = await bcrypt.hash(password, salt);
      let user = await User({ name:name, email:email, image:image,password: secPass });
      user = await user.save();
      res.json(user);
    }
  } catch (e) {
    res.status(500).json({ mes: e.message });
  }
});
authrouter.post("/auth/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    let user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ success, error: "Please try to login with valid credentials" });
    }
    const passwordcompare = bcrypt.compare(password, user.password);
    if (!passwordcompare) {
      return res
        .status(400)
        .json({ success, error: "Please try to login with valid credentials" });
    }
    res.json( user );
  } catch (e) {
    res.status(500).json({ mes: e.message });
  }
});
authrouter.post("/getuserdata",async(req,res)=>{
  try{
    const{email}=req.body;
   let user=await User.findOne({email});
   user=await user.save();
   res.json(user);
  }catch(e){
    res.status(500).json({mes:e.message})
  }
});

module.exports = authrouter;
