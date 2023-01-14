//
//  firstprojectApp.swift
//  firstproject
//
//  Created by Jayden Jardine on 12/20/22.
//

import SwiftUI
import Firebase

@main
struct firstprojectApp: App {
    init()
    {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
