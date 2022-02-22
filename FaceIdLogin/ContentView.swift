//
//  ContentView.swift
//  FaceIdLogin
//
//  Created by Caner Ağkaya on 22.02.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        NavigationView{
            
            if logStatus{
                Home()
            }else{
                LoginView()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
