//
//  Home.swift
//  FaceIdLogin
//
//  Created by Caner Ağkaya on 22.02.2022.
//

import SwiftUI
import Firebase

struct Home: View {
    // MARK: Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    //MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    var body: some View {
        
        VStack(spacing:20) {
            
            if logStatus{
                Text("Logged in")
                
                Button("Logout"){
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            }else{
                Text("Came as guest")
            }
            if useFaceID{
                // Clearing FaceID
                Button("Disable FaceID"){
                    useFaceID = false
                    faceIDEmail = ""
                    faceIDPassword = ""
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
