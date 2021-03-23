//
//  userModelData.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI
import Firebase

class userModelData: ObservableObject {
    
    // User Details ...
    @Published var userFirstName = ""
    @Published var userLastName = ""
    @Published var userType = ""
    @Published var userSchool = ""
    @Published var userMajor = ""
    @Published var userYear = ""

    //Login Details ...
    @Published var userEmail = ""
    @Published var userPassword = ""
    
    //Signup Details ...
    @Published var isSignUp = false
    @Published var password_signup = ""
    @Published var email_signup = ""
    @Published var selectedSchool = 0
    
    //Password Forget Details
    @Published var reEnterPassword = ""
    @Published var resetEmail = ""
    @Published var isLinkSend = false
        
    // Error Alerts ...
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status ...
    @AppStorage("log_status") var stats = false
    
    // Loading ...
    @Published var isLoading = false
    
    // AlertVIew With TextFields ...
    func resetPassword() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter Your Email To Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
                           password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.resetEmail = alert.textFields![0].text!
            
            // Presenting alert when email link has been sent ...
            
            self.isLinkSend.toggle()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting ...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    // Login
    func login() {
        //checking all fields are inuptted correctly ...
        
        if userEmail == "" || userPassword == "" {
            self.alertMsg = "Please fill the contents"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // checking if user is verifed or not...
            // if not verified means logging out ...
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified {
                self.alertMsg = "Please Verify Email Address"
                self.alert.toggle()
                // logging out
                try! Auth.auth().signOut()
                
                return
            }
            
            withAnimation{
                self.stats = true
            }
        }
    }
    
    // SignUp...
    func signUp() {
        if email_signup == "" || password_signup == "" || reEnterPassword == "" {
            self.alertMsg = "Please fill the contents"
            self.alert.toggle()
            return
        }
        
        if password_signup != reEnterPassword {
            self.alertMsg = "Password does not match"
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_signup + Constants.SchoolInformation.UniversityList[selectedSchool]["Domain"]!, password: password_signup) { (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // sending Verification Link ...
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil {
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.alertMsg = "Email Verification Has Been Sent"
                self.alert.toggle()
            })
        }
    }
}
