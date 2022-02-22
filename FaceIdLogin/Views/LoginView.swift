//
//  LoginView.swift
//  FaceIdLogin
//
//  Created by Caner Ağkaya on 22.02.2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginModel:LoginViewModel = LoginViewModel()
    //MARK: FaceID Properties
    @State var useFaceID: Bool = false
    
    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x:-23)
                .padding(.bottom,30)
            
            Text("Hey, \nLogin Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            // MARK: Textfields
            TextField("Email",text: $loginModel.email)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.email == "" ? Color.black.opacity(0.05):
                                Color("Yellow")
                        )
                }
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding(.top,20)
            SecureField("Password",text: $loginModel.password)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.password == "" ? Color.black.opacity(0.05):
                                Color("Yellow")
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top,15)
            
            // MARK: User Prompt to ask to store Login using FaceID on next time
            if loginModel.getBiometricStatus(){
                Group{
                    
                    if loginModel.useFaceID{
                        
                        Button{
                            // MARK: Do FaceID Action
                            Task{
                                do{
                                    try await loginModel.authenticateUser()
                                }catch{
                                    loginModel.errorMessage = error.localizedDescription
                                    loginModel.showError.toggle()
                                }
                            }
                        }label: {
                            VStack(alignment:.leading,spacing:10){
                                Label{
                                    Text("Use FaceID to login into previous account")
                                }icon:{
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("Note:You can turn of it in settings !")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .hLeading()
                        
                        
                    }else{
                        Toggle(isOn:$useFaceID){
                            Text("Use FaceID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .padding(.vertical,20)
            }
            
            Button{Task{
                do{
                    try await loginModel.loginUser(useFaceID: useFaceID)
                }catch{
//                    print(error.localizedDescription)
                    loginModel.errorMessage = error.localizedDescription
                    loginModel.showError.toggle()
                }
            }
                
            }label:{
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Blue"))
                    }
            }
            .padding(.vertical,35)
            .disabled(loginModel.email == "" || loginModel.password == "")
            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
            
            NavigationLink{
                // MARK: Going home without login
                
            }label:{
                Text("Skip for now")
                    .foregroundColor(.gray)
            }
            
        }
        .padding(.horizontal,25)
        .padding(.vertical)
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

// MARK: Extensions for UI Designing
extension View{
    
    func hLeading()->some View{
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    func hTraling()->some View{
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    func hCenter()->some View{
        self
            .frame(maxWidth:.infinity,alignment: .center)
    }
}
