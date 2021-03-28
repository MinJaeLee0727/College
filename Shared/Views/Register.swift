//
//  Register.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/21.
//

import SwiftUI

struct Register: View {
    var body: some View {
        RegisterWithSchoolEmail()
    }
}

//struct detailRegisterWithSchoolEmail: View {
//    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)
//
//    @State private var schoolIndex: Int = 0
//
//    var body: some View {
//        VStack(spacing: 30) {
//            HStack(spacing: 15) {
//                Image(systemName: "graduationcap.fill")
//                    .foregroundColor(color)
//                    .frame(width: 30, height: 30)
//
//                Picker("Please Choose Your School", selection: $schoolIndex) {
//                    ForEach(0 ..< Constants.SchoolInformation.UniversityList.count) {
//                        Text(Constants.SchoolInformation.UniversityList[$0]["Name"]!)
//                    }
//                }
//
//            }
//            .padding(.horizontal, 12)
//            .background(Color.white)
//            .cornerRadius(8)
//
//            HStack {
//            }
//
//            HStack {
//
//            }
//
//            NavigationLink(
//                destination: RegisterWithSchoolEmail(schoolIndex: $schoolIndex)) {
//                HStack {
//                Spacer()
//
//                Text("Next")
//
//                Spacer()
//
//                Image(systemName: "arrow.right")
//                }
//                .foregroundColor(.primary)
//            }
//
//            Spacer()
//        }
//        .navigationBarTitle("Information that only we know")
//        .navigationBarTitleDisplayMode(.inline)
//
//    }
//}

struct RegisterWithSchoolEmail: View {
    //    @State private var firstName: String = ""
    //    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    @State var schoolIndex: Int = 0
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oops!"
    @State private var errorMsg: String = "Something Happened"
    
    @State private var isLoading = false
    
    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)
    
    func clear() {
        self.email = ""
        self.password = ""
        self.schoolIndex = 0
        self.rePassword = ""
    }
    
    func errorCheck() -> String? {
        if self.email == "" || self.password == "" || self.rePassword == "" {
            return "Please Fill in all fields"
        }
        
        if self.password != self.rePassword {
            return "Please Match the Passwords"
        }
        
        return nil
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.errorMsg = error
            self.showingAlert.toggle()
            return
        }
        
        self.isLoading = true
        
        AuthService.signUp(email: email + Constants.SchoolInformation.UniversityList[schoolIndex]["Domain"]!, school: Constants.SchoolInformation.UniversityList[schoolIndex]["Name"]!, schoolIndex: schoolIndex, password: password, onSuccess: {
            (user) in
            self.isLoading = false
            self.clear()
            self.alertTitle = "Great!"
            self.errorMsg = "Email Has Been Sent.\nPlease Check Your Email."
            self.showingAlert = true
            return
        }) {
            (errorMessage) in
            self.isLoading = false
            print("Error \(errorMessage)")
            self.errorMsg = errorMessage
            self.showingAlert = true
            return
        }
        
    }
    
    var body: some View {
        ZStack {
            VStack {
                //            HStack(spacing: 15) {
                //                Image(systemName: "person.fill")
                //                    .foregroundColor(color)
                //                    .frame(width: 30, height: 30)
                //
                //                TextField("First Name", text: $firstName)
                //                    .disableAutocorrection(true)
                //
                //
                //                TextField("Last Name", text: $lastName)
                //                    .disableAutocorrection(true)
                //
                //            }
                //            .padding(.top, 12)
                //            .padding(.horizontal, 12)
                //            .background(Color.white)
                //            .cornerRadius(8)
                //
                
                            HStack(spacing: 15) {
                                Image(systemName: "graduationcap.fill")
                                    .foregroundColor(color)
                                    .frame(width: 30, height: 30)
                
                                Picker("Please Choose Your School", selection: $schoolIndex) {
                                    ForEach(0 ..< Constants.SchoolInformation.UniversityList.count) {
                                        Text(Constants.SchoolInformation.UniversityList[$0]["Name"]!)
                                    }
                                }
                
                            }
                
                VStack{
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .frame(width: 30, height: 30)
                            .foregroundColor(color)
                        
                        
                        TextField("Email w/o domain", text: $email)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        Text("\(Constants.SchoolInformation.UniversityList[schoolIndex]["Domain"]!)")
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(8)
                
                HStack(spacing: 15) {
                    Image(systemName: "key.fill")
                        .foregroundColor(color)
                        .frame(width: 30, height: 30)
                    
                    VStack {
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        SecureField("Re-enter Password", text: $rePassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                }
                .padding(.top, 12)
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(8)
                
                Button(action: signUp, label: {
                    
                    HStack {
                        Spacer()

                        Text("Sign Up")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .cornerRadius(8)
                    
                    
                })
                .padding(.top)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .padding(.top)
            
            if self.isLoading {
                LoadingView()
            }
        }
        .navigationTitle("Information that only we know")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct RegisterWithOutSchoolEmail: View {
    var body: some View {
        Text("High School Student")
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
