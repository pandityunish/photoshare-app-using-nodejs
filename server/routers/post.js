const express=require("express");
const Post = require("../models/Postmodel");

const postrouter=express.Router();

postrouter.post("/addpost",async(req,res)=>{
    try{
    const {title,username,userimage,userid,image,description,link,category}=req.body;
   let post=await Post({title,userimage,userid,username,image,description,link,category});
   post=await post.save();
   res.json(post);
    }catch(e){
        res.status(500).json({"mes":e.message});
    }
});
postrouter.get("/getallpost",async(req,res)=>{
    try{
        const{page,limit}=req.query;
        const skip=(page-1)*10;
     let post=await Post.find({}).skip(skip).limit(limit).sort({$natural: -1});
     
     res.json(post);
    }catch(e){
        res.status(400).json({"mes":e.message})
    }
});
postrouter.post("/getcategory",async(req,res)=>{
    try{
    const {category}=req.body;
    let posts=await Post.find({category}).sort({$natural: -1});
    res.json(posts);
    }catch(e){
        res.status(400).json({"mes":e.message})
    }
});
postrouter.post("/addcomment",async(req,res)=>{
    try {
        
    } catch (e) {
        res.status(400).json({"mes":e.message})
    }
})

module.exports=postrouter;