const mongoose=require("mongoose");
const userSchema=mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true
    },
    email:{
        type:String,
        required:true,
        trim: true,
        validate: {
            validator: (value) => {
              const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              return value.match(re);
            },
            message: "Please enter a valid email address",
          },
        
    },
    image:{
        type:String,
        required:true,
        trim:true
      },
    password: {
        required: true,
        type: String,
        trim:true
      },
});
const User=mongoose.model("Users",userSchema);
module.exports=User;