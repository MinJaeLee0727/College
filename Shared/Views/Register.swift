//
//  Register.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/21.
//

import SwiftUI

struct Register: View {
    var body: some View {
        VStack {
            NavigationLink(
                destination:
                    RegisterWithSchoolEmail1(),
                label: {
                    Text("Do you have a school email?")
                })
            
            NavigationLink(
                destination:
                    RegisterWithOutSchoolEmail(),
                label: {
                    Text("If not, click here!")
                })
        }
    }
}

// Name, University, branchSchool, userType,
struct RegisterWithSchoolEmail1: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var nickName: String = ""
    @State var universityIndex: Int = 0
    @State var userType: Int = 0
    @State var branchSchool: String = "Main"

    @State private var showingAlert = false
    @State private var alertTitle: String = "Oops!"
    @State private var errorMsg: String = "Something Happened"
    @State private var isLoading = false
    @State private var active: Bool = false
    @State private var onEditing: Bool = true
    
    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)
    
    @StateObject var loadUniversitiesService = LoadUniversitiesService()
    
    func next() {
        self.active = false
        
        print(self.firstName.isEmpty)
        print(self.lastName.isEmpty)
        print(self.nickName.isEmpty)

        if self.firstName.isEmpty || self.lastName.isEmpty || self.nickName.isEmpty {
            self.errorMsg = "Please Fill All the Content"
            self.showingAlert = true
            self.active = false
            return
        } else if universityIndex != 16 {
            self.errorMsg = "Only University of Waterloo Student can be registered in the current beta service."
            self.showingAlert = true
            self.active = false
            return
        } else {
            self.active = true
        }
    }
    
    var body: some View {
        if (self.loadUniversitiesService.universities.isEmpty) {
            LoadingView()
                .onAppear {
                self.loadUniversitiesService.loadUniversities()
                active = false
                }
        } else {
            ScrollView {
                ZStack {
                    VStack {
                        HStack(spacing: 15) {
                            Image(systemName: "person.fill")
                                .foregroundColor(color)
                                .frame(width: 30, height: 30)
                            
                            VStack {
                                HStack {
                                    TextField("First Name", text: $firstName, onEditingChanged: { isEditing in
                                        self.onEditing = true
                                    })
                                    .disableAutocorrection(true)
                                    .keyboardType(.asciiCapable)
                                    
                                    
                                    TextField("Last Name", text: $lastName, onEditingChanged: { isEditing in
                                        self.onEditing = true
                                    })
                                    .disableAutocorrection(true)
                                    .keyboardType(.asciiCapable)
                                    
                                }
                                
                                TextField("Nick Name", text: $nickName, onEditingChanged: { isEditing in
                                    self.onEditing = true
                                })
                                .disableAutocorrection(true)
                                
                            }
                            .foregroundColor(.primary)
                            
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "graduationcap.fill")
                                .foregroundColor(color)
                                .frame(width: 30, height: 30)
                            
                            Picker("Please Choose Your School", selection: $universityIndex) {
                                ForEach(0 ..< self.loadUniversitiesService.universities.count) {
                                    Text(self.loadUniversitiesService.universities[$0].name)
                                }
                            }
                            
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                        
                        
                        if !self.loadUniversitiesService.universities[universityIndex].branchSchools.isEmpty {
                            
                            Picker(selection: $branchSchool, label: Text("Select your college")) {
                                ForEach(self.loadUniversitiesService.universities[universityIndex].branchSchools, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                            
                        }
                        
                        HStack {
                            RadioButtonField(items: ["Undergraduate Student", "Graduate Student", "Ph.D. Student", "Staff", "Others"
                            ], selectedId: "Undergraduate Student") { selected in
                                if selected == "Undergraduate Student" {
                                    userType = 0
                                } else if selected == "Graduate Student" {
                                    userType = 1
                                } else if selected == "Ph. D. Student" {
                                    userType = 2
                                } else if selected == "Staff" {
                                    userType = 3
                                } else if selected == "Others" {
                                    userType = 4
                                }
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 24)
                        
                        
                        NavigationLink(destination: SchoolEmail2_undergraduate(university: self.loadUniversitiesService.universities[universityIndex].name, branchSchool: branchSchool, firstName: firstName, lastName: lastName, nickName: nickName, universityIndex: universityIndex, userType: userType, universityDomain: self.loadUniversitiesService.universities[universityIndex].domain, undergraduatePrograms: self.loadUniversitiesService.universities[universityIndex].undergraduatePrograms), isActive: $active) {
                            HStack {
                                Spacer()
                                
                                Text("Next")
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                next()
                            })
                        }
                        .alert(isPresented: $showingAlert, content: {
                            Alert(title: Text(alertTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                        })
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .padding(.top)
                        
                        Spacer()
                    }
                    .padding(.top)
                }
                
                if self.isLoading {
                    LoadingView()
                }
            }
            .navigationBarItems(trailing: Group{
                if onEditing {
                    Button(action: hideKeyboard, label: {
                        Text("Done")
                    })
                }
            })
            .navigationTitle("Information that only we know")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Major, Year
struct SchoolEmail2_undergraduate: View {
    @State var university: String
    @State var branchSchool: String
    @State var firstName: String
    @State var lastName: String
    @State var nickName: String
    @State var universityIndex: Int
    @State var userType: Int
    @State var universityDomain: String
    @State var undergraduatePrograms: [String]

    @State var major: String = ""
    @State var year: Int = 1
    
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oops!"
    @State private var errorMsg: String = "Something Happened"
    @State private var isLoading = false
    @State private var searchText = ""
    @State private var active = false
    @State private var onSearching: Bool = false

    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)
    @StateObject var loadUniversitiesService = LoadUniversitiesService()

    func select(major: String) {
        self.major = major
    }
    
    func next() {
        if self.major.isEmpty {
            errorMsg = "Please Choose Your Major"
            showingAlert = true
            active = false
        } else {
            active = true
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.onSearching = true
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                if onSearching  {
                    Button("Cancel") {
                        hideKeyboard()
                        self.searchText = ""
                        self.onSearching = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            List {
                ForEach(undergraduatePrograms.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                    searchText in
                    Button(action: {self.major = searchText}, label: {
                        if self.major == searchText {
                            Text(searchText)
                                .foregroundColor(color)
                        } else {
                            Text(searchText)
                        }
                    })
                }
            }
            .navigationBarTitle(Text("Choose Your Major"))
            .resignKeyboardOnDragGesture()
            
            NavigationLink(
                destination: RegisterWithSchoolEmail3(university: university, branchSchool: branchSchool, firstName: firstName, lastName: lastName, nickName: nickName, universityIndex: universityIndex, userType: userType, major: major, year: year, universityDomain: universityDomain), isActive: $active) {
                HStack {
                    Spacer()
                    
                    Text("Next")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                }
                .simultaneousGesture(TapGesture().onEnded{
                                    next()
                                })
                .foregroundColor(.primary)
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
            })

            Spacer()
        }
        .onAppear{
            self.loadUniversitiesService.loadUniversities()
            active = false
            self.major = ""
        }
        .navigationBarTitle("Information that only we know")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct RegisterWithSchoolEmail3: View {
    @State var university: String
    @State var branchSchool: String
    @State var firstName: String
    @State var lastName: String
    @State var nickName: String
    @State var universityIndex: Int
    @State var userType: Int
    @State var major: String
    @State var year: Int
    @State var universityDomain: String
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oops!"
    @State private var errorMsg: String = "Something Happened"
    @State private var isLoading = false
    @State private var active = false
    
    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)

    func clear() {
        self.email = ""
        self.password = ""
        self.rePassword = ""
    }
    
    func errorCheck() -> String? {
        if email == "" || password == "" || rePassword == "" {
            return "Please fill all fields"
        }
        
        if password != rePassword {
            self.password = ""
            self.rePassword = ""
            return "Please match your passwords"
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
        
        AuthService.signUp(firstName: firstName, lastName: lastName, nickName: nickName, verified: true, major: major, year: year, email: email + universityDomain, userType: userType, university: university, universityIndex: universityIndex, branchSchool: branchSchool, password: password, onSuccess: {
            (user) in
            self.isLoading = false
            self.clear()
            self.alertTitle = "Great!"
            self.errorMsg = "Email Has Been Sent.\nPlease Check Your Email."
            self.showingAlert = true
            active = true
            return
        }) {
            (errorMessage) in
            self.isLoading = false
            print("Error \(errorMessage)")
            self.errorMsg = errorMessage
            self.showingAlert = true
            active = false
            return
        }
        
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .frame(width: 30, height: 30)
                            .foregroundColor(color)
                        
                        
                        TextField("Email w/o domain", text: $email)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.primary)
                        
                        Text(universityDomain)
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 12)
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
                    .foregroundColor(.primary)
                }
                .padding(.top, 12)
                .padding(.horizontal, 12)
                .cornerRadius(8)
                
                NavigationLink(
                    destination: LoginView(), isActive: $active) {
                    HStack {
                        Spacer()
                        
                        Text("Sign Up")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        signUp()
                    })
                    .foregroundColor(.primary)
                }
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                })
            }
            
            if self.isLoading {
                LoadingView()
            }
        }
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
