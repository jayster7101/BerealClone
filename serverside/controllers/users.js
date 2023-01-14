/**
 * Server request logic for incoming or outbound requests
 * imports data types created as well as functions 
 */

 //const { request, response } = require("express");
// const { request } = require("express");
// const express = require("express");
const {Post, User} = require ("../data")

const {getUser,get_friends, checkIfInDb, add_to_db, getAllFriendsPosts, getUserOnLoadFullDataSuite} = require("../functions");
const { use } = require("../routes/users");
//import {}  from "../functions"


// newTea handler function for post tea route
 const queryUser = async (req, res, next) => {
  let uid = req.params.uid
  let user = await getUser(uid)
    //res.json({message: "POST new tea"}); // dummy function for now
      res.status(200);
      res.send(user);
      //console.log(friends)
      
      
    
};


const queryFriends = async (req,res) =>{
  let uid = req.params.uid
  let friends = await get_friends(uid)
  res.status(200);
  res.send(friends);
  //console.log(friends)
}

const queryUsername = async (req, res) => {

  let username =  req.params.username
  let isIn = await checkIfInDb(username)
  res.status(200)
  res.send(isIn)
}

const addToDb = async (req, res) =>{
  //const name  = req;
  const username = (req.body.username);
  const uid = (req.body.uid);
  console.log(username,uid)
  await add_to_db(uid,username)
  res.status(200)
  res.send("got it")
}

const queryInitialLoadData =  async (req, res) =>{ 
  // passed in uid
  let uid = req.params.uid
  //console.log("uid,", uid)
  let data = await getUserOnLoadFullDataSuite(uid)
  res.status(200)
  res.send(data)
  console.log("friends posts,", data)
}


module.exports = {queryUser, queryFriends, queryUsername, addToDb, queryInitialLoadData};
