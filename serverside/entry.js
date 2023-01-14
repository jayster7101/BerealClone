const { request } = require("express");
const express = require("express");
const app = express();
var $ = require("jquery");
const port = process.env.PORT || 3000;
const routes = require('./routes/users');

app.use(express.json());
app.use(express.urlencoded({ extended: true }))

app.use('/', routes); //to use the routes

const listener = app.listen(process.env.PORT || 3000, () => {
    console.log('Your app is listening on port ' + listener.address().port)
})




























// Initialize Firebase Analytics and get a reference to the service
//const analytics = getAnalytics(FBapp);

// const server = http.createServer((req, res) => {
//     console.log(`${req.method} request received for ${req.url}`);

//     // Set the response status code and content type
//     res.statusCode = 200;
//     res.setHeader('Content-Type', 'text/plain');

//     // Send a response back to the client
//     res.end('Hello, Worldd!');
// });

// app.listen(port, () => {
//   console.log(`Server listening on port ${port}`);
// });







//WORKING BUT TRYINg new format
// app.get("/", (req, responce) => {
//   responce.status(200);
//   responce.send("home page fucker");
//   //get_friends(db, "Jayden");
//  // add_to_db()
//  let user = new User("billybob","Cameron");
//  createUser(db,user)
// });

// app.get(`/users`, (req,res)=>{
    

// })






// app.get("/", (req, responce) => {
//     req.params
// });




// mapping username to another mapping of key: <freindsusername>, value: <path to freind in database

//  app sends request to server with something to key all of their ffreinds to display
// now with the list of freinds objects that holds all the info that we need, we display on swift app

// how to hold friends
// array of friends
// map of freinds that either stores a mapping of key: <freindsusername>, value: <path to freind in database or a string to the path to the freind
//  itterate through map

// process
// query database to get list of friends
// now








