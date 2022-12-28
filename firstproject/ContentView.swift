//
//  ContentView.swift
//  firstproject
//
//  Created by Jayden Jardine on 12/20/22.
//

import SwiftUI

struct ContentView: View {
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

                Button(action: {main_shown.toggle() }, label: {
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
