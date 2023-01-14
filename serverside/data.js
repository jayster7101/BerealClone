class User {
    constructor(id, name, post, friends, profPic){
        this.id = id
        this.name = name
        this.post = post ? post: {}
        this.friends = friends ? friends: []
        this.postHisotry = []
        this.profPic = profPic ? profPic : ""
    }

    get _id(){
        return this.time
    }

    get _name(){
        return this.name
    }

    get _post(){
        return this.post
    }
    
    get _friends(){
        return this.friends
    }

    get _profPic(){
        return this.profPic
    }

    add(post){
        this.postHisotry.push(post)
    }

    to_Firestore(){
        return {
            id: this.id,
            name: this.name,
            post: this.post? this.post.to_Firestore() : {},
            friends: this.friends ? this.friends : [],
            profPic: this.profPic? this.profPic : "",
            };
    }
}
class Post {
    // title;
    // pathToMainImage;
    // pathToSecondaryImage;
    // time;
    constructor(title, pathToMainImage, pathToSecondaryImage, time, comments){
        this.title = title
        this.pathToMainImage = pathToMainImage
        this.pathToSecondaryImage = pathToSecondaryImage
        this.time = time
        this.comments = comments? comments : []
    }
    get _title(){
        return this.title
    }

    get _pathToMainImage() {
        return this.pathToMainImage
    }

    get _pathToSecondaryImage(){
        return this.pathToSecondaryImage

    }

    get _time(){
        return this.time
    }

    get _comments(){
        return this.comments
    }

    to_Firestore(){
        return {
            "title": this.title,
            "pathToMainImage": this.pathToMainImage,
            "pathToSecondaryImage": this.pathToSecondaryImage,
            "time": this.time,
            "comments": this.comments? this.comments : []
        }
    }
}

module.exports = {User, Post};