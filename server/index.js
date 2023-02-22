const express =require("express");
const mongoose=require("mongoose");
const authrouter = require("./routers/auth");
const commentrouter = require("./routers/comment");
const postrouter = require("./routers/post");
const app=express();
const PORT=3000;
app.use(express.json());
app.use(authrouter);
app.use(postrouter);
app.use(commentrouter);
let db="mongodb+srv://yunishpandit:yunishhello@cluster0.ast8foi.mongodb.net/?retryWrites=true&w=majority";
mongoose.set('strictQuery', false);
mongoose.connect(db).then(()=>{
    console.log("Conected successfully")
}).catch((e)=>{
    console.log(e);
});
app.listen(PORT,"0.0.0.0",()=>{
    console.log("Connected to "+PORT);
})
