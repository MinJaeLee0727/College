//
//  LoginView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/21.
//

import SwiftUI

struct LoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oops!"
    @State private var errorMsg: String = "Something Happened"
    
    @State private var isLoading = false
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func errorCheck() -> String?{
        if self.email == "" || self.password == "" {
            return "Please Fill in all fields"
        }
        
        return nil
    }
    
    func signIn() {

        if let error = errorCheck() {
            self.errorMsg = error
            self.showingAlert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            withAnimation {
                self.isLoading.toggle()
            }
            self.clear()
        }) {
            (errorMessage) in
            withAnimation {
                self.isLoading.toggle()
            }
            print("Error \(errorMessage)")
            self.errorMsg = errorMessage
            self.showingAlert.toggle()
            return
        }
    }

    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 25)
                    
                    HStack(spacing: 15) {
                        TextField("Email", text: $email)
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .foregroundColor(.black)
                            .cornerRadius(5.0)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                    }
                    .padding(.top)
                    
                    HStack(spacing: 15) {
                        SecureField("Password", text: $password)
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .foregroundColor(.black)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .cornerRadius(5.0)
                        
                    }
                    .padding(.top)
                    
                    Button(action: signIn, label: {
                        
                        HStack {
                            Spacer()
                            
                            Text("Login")
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .cornerRadius(8)
                        
                        
                    })
                    .padding(.top)
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text(alertTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                    })
                    
                    NavigationLink(
                        destination: Register(),
                        label: {
                            HStack {
                                Spacer()
                                
                                Text("Sign Up")
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .cornerRadius(8)
                        })
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}, label: {
                        
                        Text("Can't sign up?")
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .cornerRadius(8)
                        
                        
                    })
                    .padding(.top)
                }
                
                if isLoading {
                    LoadingView()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}
