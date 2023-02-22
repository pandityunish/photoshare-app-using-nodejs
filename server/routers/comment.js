const express=require("express");
const Comment = require("../models/Commentmodel");

const commentrouter=express.Router();

commentrouter.post("/getpostcomment",async(req,res)=>{
    try {
        const{postid}=req.body;
        let comment=await Comment.find({postid});
        
        res.json(comment);
    } catch (e) {
        res.status(500).json({mes:e.message})
    }
});
commentrouter.post("/addpostcomment",async(req,res)=>{
    try {
        const{commenttitle,username,userimage,postid}=req.body;
        let comment=await Comment({commenttitle,username,userimage,postid});
        comment=await comment.save();
        res.json(comment);
    } catch (e) {
        res.status(500).json({mes:e.message})
    }
});
module.exports=commentrouter;