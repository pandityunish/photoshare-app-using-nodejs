const mongoose=require("mongoose");

const commentScheme=mongoose.Schema({
    commenttitle:{
        type:String,
        required:true,
        trim:true
    },
    postid:{
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
    
});
const Comment=mongoose.model("Comment",commentScheme);
module.exports=Comment;