// Import the functions you need from the SDKs you need

const {Post, User} = require ("./data")
const { initializeApp } = require("firebase/app");
//const { getAnalytics } = require ("firebase/analytics");
const { getAuth } = require("firebase/auth");
const {
  getFirestore,
  collection,
  getDocs,
  getDoc,
  setDoc,
  doc,
  where,
  query,
  documentId,
  DocumentReference,
} = require("firebase/firestore");

const {getStorage, ref, getDownloadURL} = require("firebase/storage")
const { json } = require("express");
const { post } = require("jquery");
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAaqEkHauahKWX68lpOZWZcOp5TKbBCYoA",
  authDomain: "berealclone-7cfc3.firebaseapp.com",
  databaseURL: "https://berealclone-7cfc3-default-rtdb.firebaseio.com",
  projectId: "berealclone-7cfc3",
  storageBucket: "berealclone-7cfc3.appspot.com",
  messagingSenderId: "894010498509",
  appId: "1:894010498509:web:6412cda8ece6a2c40fb884",
  measurementId: "G-FD32PS7V0Z",
};
// Initialize Firebase
const FBapp = initializeApp(firebaseConfig);
const storage = getStorage(FBapp);

const db = getFirestore(FBapp);
// Initialize Firebase Authentication and get a reference to the service
const auth = getAuth(FBapp);

async function get_friends(user) {
  let foundFriends = [];
  const usersRef = collection(db, "users");

  // Create a query against the collection.
  const q = query(usersRef, where("id", "==", user));
  const querySnapshot = await getDocs(q);
  for (const doc of querySnapshot.docs) {
    // doc.data() is never undefined for query doc snapshots
    let data = doc.data();
    let friends = data["freinds"];
    console.log(doc.id, " => ", data);
    for (const key in friends) {
      if (Object.hasOwnProperty.call(friends, key)) {
        const friend = friends[key]; // users unique id ref in db

        //getting friends data using friends uid
        await getUser(friend).then((data) => {
          foundFriends.push(data);
        });
        // now query friends to get their data
      }
    }
  }
  return foundFriends;
}

async function add_to_db(uid, username) {
  let post = new Post("", "", "", "", []);
  let user = new User(uid, username, post, [], ""); // user id, username, empty post
  await createUser(user)
  //console.log(user._id)
}

// user is a User obj
async function createUser(user) {
  
  // check if id is already in db
  if (!(await checkIfInDb(user.id))) {
    console.log("already in db");
    return;
  } // return since user is already in database

  console.log("not in db");
  add_to_users(user);

  //add to database
}

async function checkIfInDb(idToCheck) {
  const usersRef = collection(db, "users");
  const q = query(usersRef, where("id", "==", idToCheck));
  return (querySnapshot = (await getDocs(q)).empty); //.then((value)=>{return(value.empty)})
}

async function getUser(user) {
  const usersRef = collection(db, "users");
  const q = query(usersRef, where("id", "==", user));
  var foundUser;
  await getDocs(q).then((qs) => {
    qs.forEach((doc) => {
      foundUser = doc.data();
    });
  });
  return foundUser;
}

//LEFT OFF here user.id isnt working but when passing in string, it works
async function add_to_users(User) {
  //console.log(User._id)
  const usersRef = doc(db, "users", User.id); // create refrence to specific user
  const user = User.to_Firestore();
  //const post = {"post": User.post.to_Firestore()}
  await setDoc(usersRef, user).catch((err) => {
    console.log("error with sending post", err);
  });
}


/**
 * gets user post by uid and then access the friends property to then query each friend and store and return the post object on the friends section
 */
async function getAFriendPost(friendsUid){
  console.log(friendsUid);
  //const usersRef = doc(db, "users");
  const friend =  await getUser(friendsUid); // now have access to friend of user 
  const post = friend.post
  const poster = friend.name
  return [{"poster":poster},post];
  
  //return post;
}

async function getAllFriendsPosts(uid){
  let friendsPost = [];
  let user = await getUser(uid);
  let usersFriends = user.friends
   for (const friend of usersFriends) {
    
    let post = await getAFriendPost(friend)
    console.log(friend,post)
    if(post[1]) {
       await getPicturePath(post[1].pathToMainImage).then((link)=>{
        post[1].pathToMainImage = link;
      })
       await getPicturePath(post[1].pathToSecondaryImage).then((link)=>{
        post[1].pathToSecondaryImage = link;
      })
      friendsPost.push(post) 
    }// checks to see if the users post is empty 
   
  }
  return {user,friendsPost};
  //console.log(friendsPost);
}

async function getUserOnLoadFullDataSuite(uid){
  let {user, friendsPost} = await getAllFriendsPosts(uid);
  // for(let post of friendsPost){ // for each post find the url based on the path to the users picture and then redefine image to the new found url
  //   post.pathToMainImage = await getPicturePath(post.pathToMainImage);
  //   post.pathToSecondaryImage = await getPicturePath(post.pathToSecondaryImage);
  // }
  let profilePicURL = await getPicturePath(user.profPic);
  return {
    "name":user.name,
    "profPicUrl":profilePicURL,
    "friendsPosts" : friendsPost,
  }
  }

module.exports = { getUser, get_friends, checkIfInDb, add_to_db, getAllFriendsPosts, getUserOnLoadFullDataSuite};


async function getPicturePath(profPicPath){
  let URL;
  
  const profPicRef = ref(storage, "profilePicture/defaultImage.png");
  
  // Get the download URL
  await getDownloadURL(profPicRef)
    .then((url) => {
      
      // Insert url into an <img> tag to "download"
      URL = url;
    })
    .catch((error) => {
      // A full list of error codes is available at
      // https://firebase.google.com/docs/storage/web/handle-errors
      switch (error.code) {
        case 'storage/object-not-found':
          // File doesn't exist
          break;
        case 'storage/unauthorized':
          // User doesn't have permission to access the object
          break;
        case 'storage/canceled':
          // User canceled the upload
          break;
  
        // ...
  
        case 'storage/unknown':
          // Unknown error occurred, inspect the server response
          break;
      }
    });
    //console.log("url", URL)
    return URL;
}