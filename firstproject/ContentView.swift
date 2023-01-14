//
//  ContentView.swift
//  firstproject
//
//  Created by Jayden Jardine on 12/20/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct ContentView: View {
  var body: some View {
    NavigationView {
        LoginView().navigationBarBackButtonHidden(true)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct header: View {
    var body: some View
    {
        HStack (alignment: .top, spacing: 30){
           // Divider().overlay(.black).frame(width:0)
            // emoji
            HStack (spacing: -5){
                Image(systemName:"person.2.fill").foregroundColor(.white)
                    .font(.title2)
                Image(systemName:"circle.fill").foregroundColor(.red)
                    .font(.caption2)
                    .padding(.bottom, 15)
            }
            Spacer()
            Text("BeReal.")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(0)
            Spacer()
            profile_header_image()
            //Divider().overlay(.black).frame(width:0)
            
            //BeReal.
            //profile image
            
        }
    }
}
struct profile_header_image: View{
    
    var body: some View {
        Image("profile_pic")
            .resizable()
            .frame(width:40,height:40)
            .cornerRadius(100)
    }
}
struct page_options: View{
    @State private var freinds = true
    var body: some View {
        HStack (alignment: .top){
            Button(action: {freinds ? freinds.toggle() : nil}, label: {Text("My Freinds")
                    .font(.body)
                    .foregroundColor(freinds ? .gray: .white)
                    .fontWeight(.semibold)})
            Button(action: {!freinds ? freinds.toggle() : nil}, label: {Text("Discovery")
                    .font(.body)
                    .foregroundColor(freinds ? .white: .gray)
                    .fontWeight(.semibold)})

        }
        //myfreinds
        //discovery
    }
}

func print_button_name (bname:String) {
    print(bname)
}

func freinds_or_discoveryview (){
    
}
struct freinds_view : View{
//    var idk = post_data(profilePic: "String", profileName: "String", timePosted: "String", posted_loation: "")
    var body : some View {
        ScrollView{
            page_options()
            VStack(spacing: 30){
                view_cell(text: "daddy")
                view_cell(text: "daddy")
                
                
//                ForEach(0..<10){
//                    Text("Item \($0)")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .frame(width: UIScreen.main.bounds.width, height: 200)
//                        .background(.red)
//
//                }
            }
        }.frame(maxWidth: UIScreen.main.bounds.width)//.padding(10)
    }
    
}

struct view_cell : View{
    // text is the posties username
    var text: String
    
    var body : some View {
        
        
        //Text(text).foregroundColor(.white)
        VStack(alignment: .leading){
            //header
            view_header(text: text)
            //post body
            view_body(mainImage: "profile_pic")
        }.foregroundColor(.white)
        
    }
}

// creates header view and needs prof pic, prof name, time since post
struct view_header : View{
    var text: String
    var body : some View {
        HStack (){
            //proff pic
            profile_header_image()
            
            
            //name and time/ possible place
            VStack (alignment: .leading){
                Text(text).foregroundColor(.white)
                Text("Time and place").foregroundColor(.gray)
            }
        }.padding(.bottom,-3).padding(.leading, 8)
        //Text(text).foregroundColor(.white)
    }
}


struct view_body : View{
    
    // needs to be passsed in,
        // default image string, then turn to
    @State private var main_shown = false
    //var text: String
    // selfie image
    var mainImage : String? = nil
    var defaultImage = "defaultImage"
    
    // front facing camera
    var secondaryImage :  String? = nil
    var body : some View {
        VStack (alignment: .leading){
            ZStack(alignment: .topLeading){
                    GeometryReader { geometry in
                        Image(main_shown ? (mainImage ?? defaultImage) : (secondaryImage ?? defaultImage))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(minWidth: geometry.size.width, maxWidth: geometry.size.width, minHeight: 525, maxHeight: 525)
                            .cornerRadius(20)
                            .transaction { transaction in
                                transaction.animation = nil
                            }
                            
                    }.frame(height: 525)

                Button(action: {main_shown.toggle()
                    let url = URL(string: "http://localhost:3000/")!
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                      if let error = error {
                        print("Error: \(error)")
                        return
                      }

                      guard let httpResponse = response as? HTTPURLResponse,
                            (200...299).contains(httpResponse.statusCode) else {
                        print("Error: Invalid HTTP response code")
                        return
                      }

                      if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response: \(dataString)")
                      }
                    }
                    task.resume()
                }, label: {
                    Image(main_shown ? (secondaryImage ?? defaultImage) : (mainImage ?? defaultImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(width: 110, height: 125)
                        .cornerRadius(16)
                        //.foregroundColor(.white).cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 1.8))
                        .padding()
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                })
                
            }
                
        }
            
            
        Text("Tottaly cool title ").padding(.leading, 15).padding(.trailing, 15).font(.callout)
            Text("Add a comment...").padding(.leading, 15).padding(.trailing, 15).font(.footnote).foregroundColor(.gray)
            
        }//
        //.frame()
        //Text(text).foregroundColor(.white)
    }


// array of data objects containing
    // profile pic
    // profile name
    // time since post & where
    
    // picture itself
    // picture caption
    // etc
class post_data {
    
    init (profilePic: String, profileName: String, timePosted: String, posted_loation: String, mainPicture: String, secondaryPicture : String, pictureCaption: String) {
        self.profilePic = profilePic
        self.profileName = profileName
        self.timePosted = timePosted
        self.posted_loation = posted_loation
        self.mainPicture = mainPicture
        self.secondaryPicture = secondaryPicture
        self.pictureCaption = pictureCaption
        
        
        // call to data base and set profile pic
    }// constructor
    
    let profilePic: String
    let profileName: String
    let timePosted: String
    let posted_loation: String?
    
    let mainPicture: String
    let secondaryPicture : String
    
    let pictureCaption: String
    // picture caption
    // etc
    
}

struct LoginView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var errorm: String = ""
  @State private var isError: Bool = false
  @State private var uid: String = ""
  
  var body: some View {
    VStack {
      TextField("Email", text: $email)
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
      
      SecureField("Password", text: $password)
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
      
      VStack {
          NavigationLink(destination: mainView(uid:uid).navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
            Button(action: login) {
              Text("Log In")
            }
          }
          .padding()
          .background(Color.blue)
          .foregroundColor(Color.white)
          .cornerRadius(5.0)
          
         NavigationLink(destination: SignupView()) {
                    Text("not a user yet ?")
                  }
                  .padding(5)
                  .background(Color.blue)
                  .foregroundColor(Color.white)
                  .cornerRadius(5.0)
                  .font(.footnote)
          isError ? Text(errorm).foregroundColor(.blue) : nil
      }
    }
  }
  
  @State private var isLoggedIn: Bool = false
  
  func login() {
    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
      if let error = error {
        print("Error signing in:", error)
          errorm = error.localizedDescription
          isError = true
        return
      }
        
        if let user = authResult?.user {
            // Use the user object safely
            uid = user.uid
            //print("Logged in user UID:", uid)
          }
      
      self.isLoggedIn = true
    }
  }
}



struct mainView :View{
    @State var uid: String
    init(uid: String) {
        
        self.uid = uid
        print(uid)
        getStartupData(uid: "userId") { (user) in
            if let user = user {
                // Use the user object here
                print(user)
            } else {
                // Handle error
                print("Error getting user data")
            }
        }

        // call to database with uid
       // once called info will be givenback like their freinds list and process data like that
        
    }
    var body: some View {
        ZStack (alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            VStack(alignment: .center, spacing: 0){
                    header()
                    
                    //view_cell(text: "Daddy")
                    freinds_view()
                    
    //                MyView()
    //                Text("random text ")
                }

        }

    }
}

struct SignupView: View {
  @State private var validUsername: Bool = false
  @State private var Username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var passwordConfirmation: String = ""
    @State private var errorm: String = ""
    @State private var isError: Bool = false
    @State private var auto: Bool = false
  var body: some View {
    VStack {
        TextField("Username", text: $Username )
            .onChange(of: Username) { _ in
                         //try one of these
                Username = Username.replacingOccurrences(of: " ", with: "")
                email = email.replacingOccurrences(of: " ", with: "")
                         //input = input.replacingOccurrences(of: " ", with: "")
                         //input = input.filter{ s in s != " "}
                    }
            .onChange(of: Username, perform: { value in
                            // Call your function here
                 checkUsername(username: Username){(rvalue) in
                     validUsername = rvalue
                 }
                // make sure username fits database type
                            
                        })
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
        
        TextField("Email", text: $email)
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
      
      SecureField("Password", text: $password)
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
      
      SecureField("Confirm Password", text: $passwordConfirmation)
        .padding()
        .background(Color.white)
        .cornerRadius(5.0)
      
      Button(action: signup) {
        Text("Sign Up")
      }
      .disabled(email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty || password != passwordConfirmation || !validUsername)
      .padding()
      .background(((email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty || password != passwordConfirmation || !validUsername) ? Color.gray : Color.blue) )
      .foregroundColor(Color.white)
      .cornerRadius(5.0)
    
        isError ? Text(errorm).foregroundColor(.blue) : nil
    }
       !isError ? NavigationLink("", destination: LoginView().navigationBarBackButtonHidden(true),isActive: $auto) : nil
  }
  
  func signup() {
    if password != passwordConfirmation {
      print("Error: Passwords do not match")
      return
    }
    
      Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
        if let error = error {
          isError = true
          errorm = error.localizedDescription
          print("Error signing up:", errorm)
          return
        }
        if authResult?.user.uid == nil { return }
        //user signed up, now add to database
        isError = false
        auto = true
          addToDb(uid: authResult?.user.uid ?? "", username: Username, completion: { fail in
          if fail {
              isError = true
              errorm = "The server seems to be down, please try again later"
              
            // addToDb failed, delete the user
            authResult?.user.delete { error in
              if let error = error {
                print("Error deleting user:", error.localizedDescription)
                return
              }
              print("User deleted successfully")
            }
          }
        })
      })
    }
  }





func checkUsername(username: String, completion: @escaping (Bool) -> Void) {
    var _data : Bool = false
    guard let url = URL(string: "http://localhost:3000/inDB/\(username)") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                //guard let data = data else { return }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    if (dataString == "true"){ _data = true}
                 // print("Response: \(dataString)")
                } else {return}
                
            }
            completion(_data)
        }
    

        dataTask.resume()
}

    
func addToDb(uid: String, username: String, completion: ((Bool) -> Void)? = nil) {
    var success = false // set this to true if the user was added to the database successfully, or false otherwise
    guard let url = URL(string: "http://localhost:3000/add") else {
        fatalError("Missing Url")
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let body = ["uid": uid, "username" : username]
    let bodyData = try? JSONSerialization.data(
        withJSONObject: body,
        options: []
    )
    request.httpMethod = "POST"
    request.httpBody = bodyData
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    //print(request.httpBody)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {                                                 // check for fundamental networking error
            print("error=\(String(describing: error?.localizedDescription))")
            return
        }

        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }

        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString))")
        success = true // set this to true if the user was added to the database successfully, or false otherwise
          
    }
    completion?(success)
    task.resume()

    
}



func getStartupData(uid:String, completion: @escaping (User?) -> ()) {
    guard let url = URL(string: "http://localhost:3000/friendsPosts/\(uid)") else { fatalError("Missing URL") }
    
    let urlRequest = URLRequest(url: url)
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        if let error = error {
            print("Request error: ", error)
            completion(nil)
            return
        }
        guard let response = response as? HTTPURLResponse else { return }
        if response.statusCode == 200 {
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                let jsonData = dataString.data(using: .utf8)
                if(jsonData == nil){
                    completion(nil)
                    return
                }
                do {
                    let user = try User(dataString)
                    for post in user.friendsPosts{
                        for element in post {
                            if let poster = element.poster {
                                print(poster)
                            }
                            if let pathToMainImage = element.pathToMainImage {
                                print(pathToMainImage)
                            }
                            if let time = element.time {
                                print(time)
                            }
                            if let title = element.title {
                                print(title)
                            }
                            if let comments = element.comments {
                                print(comments)
                            }
                            if let pathToSecondaryImage = element.pathToSecondaryImage {
                                print(pathToSecondaryImage)
                            }
                        }
                    }
                    completion(user)
                } catch {
                    print("Error decoding json: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
                return
            }
        } else {
            completion(nil)
        }
    }
    dataTask.resume()
}


//
//class Post {
//    var pathToSecondaryImage: URL
//    var comments: [String]
//    var title: String
//    var time: String
//    var pathToMainImage: URL
//
//    init(pathToSecondaryImage: String, comments: [String], title: String, time: String, pathToMainImage: String) {
//        self.pathToSecondaryImage = URL(string: pathToSecondaryImage)!
//        self.comments = comments
//        self.title = title
//        self.time = time
//        self.pathToMainImage = URL(string: pathToMainImage)!
//    }
//}


//class Post: Decodable {
//    var pathToSecondaryImage: URL
//    var comments: [String]
//    var title: String
//    var time: String
//    var pathToMainImage: URL
//
//    enum CodingKeys: String, CodingKey {
//        case pathToSecondaryImage
//        case comments
//        case title
//        case time
//        case pathToMainImage
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.pathToSecondaryImage = try container.decode(URL.self, forKey: .pathToSecondaryImage)
//        self.comments = try container.decode([String].self, forKey: .comments)
//        self.title = try container.decode(String.self, forKey: .title)
//        self.time = try container.decode(String.self, forKey: .time)
//        self.pathToMainImage = try container.decode(URL.self, forKey: .pathToMainImage)
//    }
//}


//class User {
//    var name: String
//    var profPicUrl: URL
//    var friendsPosts: [Post]
//
//    init(name: String, profPicUrl: String, friendsPosts: [[String: Any]]) {
//        self.name = name
//        self.profPicUrl = URL(string: profPicUrl)!
//        self.friendsPosts = friendsPosts.map { post in
//            Post(pathToSecondaryImage: post["pathToSecondaryImage"] as! String,
//                 comments: post["comments"] as! [String],
//                 title: post["title"] as! String,
//                 time: post["time"] as! String,
//                 pathToMainImage: post["pathToMainImage"] as! String)
//        }
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try User(json)



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try User(json)

import Foundation

// MARK: - User
struct User: Codable {
    let name: String
    let profPicURL: String
    let friendsPosts: [[FriendsPost]]

    enum CodingKeys: String, CodingKey {
        case name
        case profPicURL = "profPicUrl"
        case friendsPosts
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil,
        profPicURL: String? = nil,
        friendsPosts: [[FriendsPost]]? = nil
    ) -> User {
        return User(
            name: name ?? self.name,
            profPicURL: profPicURL ?? self.profPicURL,
            friendsPosts: friendsPosts ?? self.friendsPosts
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FriendsPost
struct FriendsPost: Codable {
    let poster: String?
    let pathToMainImage: String?
    let time, title: String?
    let comments: [JSONAny]?
    let pathToSecondaryImage: String?
}

// MARK: FriendsPost convenience initializers and mutators

extension FriendsPost {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FriendsPost.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        poster: String?? = nil,
        pathToMainImage: String?? = nil,
        time: String?? = nil,
        title: String?? = nil,
        comments: [JSONAny]?? = nil,
        pathToSecondaryImage: String?? = nil
    ) -> FriendsPost {
        return FriendsPost(
            poster: poster ?? self.poster,
            pathToMainImage: pathToMainImage ?? self.pathToMainImage,
            time: time ?? self.time,
            title: title ?? self.title,
            comments: comments ?? self.comments,
            pathToSecondaryImage: pathToSecondaryImage ?? self.pathToSecondaryImage
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
