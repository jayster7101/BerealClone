/**
 * Routes.js sets up the request url with the verbage and connects it to the function handler
 */


const express = require('express'); //import express

// 1.
const router  = express.Router(); 

// 2. creates and gets the controller 
const usersController = require('../controllers/users'); 

// 3. sets up the request type and path with the function handler
router.get(`/user/:uid`, usersController.queryUser); 

router.get(`/getFriends/:uid`, usersController.queryFriends); 

router.get(`/inDB/:username`, usersController.queryUsername)

router.post(`/add`,usersController.addToDb)

router.get(`/friendsPosts/:uid`, usersController.queryInitialLoadData)


// 4. exports the 
module.exports = router; // export to use in server.js
