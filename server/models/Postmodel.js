const mongoose=require("mongoose");

const postScheme=mongoose.Schema({
    title:{
        type:String,
        required:true,
        trim:true
    },
    username:{
        type:String,
        required:true,
        trim: true,

        
    },
    userimage:{
        type:String,
        required:true,
        trim: true,

        
    },
    userid:{
        type:String,
        required:true,
        trim: true,

        
    },
    image:{
        type:String,
        required:true,
        trim: true,

        
    },
    description:{
        type:String,
        required:true,
        trim:true
      },
    link: {
        required: true,
        type: String,
        trim:true
      },
      category:{
        required: true,
        type: String,
        trim:true
      }
});
const Post=mongoose.model("Post",postScheme);
module.exports=Post;