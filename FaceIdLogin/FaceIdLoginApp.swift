//
//  FaceIdLoginApp.swift
//  FaceIdLogin
//
//  Created by Caner Ağkaya on 22.02.2022.
//

import SwiftUI
import Firebase

@main
struct FaceIdLoginApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
