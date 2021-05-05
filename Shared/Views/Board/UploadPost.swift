//
//  UploadPost.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/21.
//

import SwiftUI

struct UploadPost: View {
    @State var universityName: String
    @State var motherBoardName: String
    @State var boardName: String
    
    let contentPlaceHolder: String = "Content (optional)"

    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var imageData: Data = Data()
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No"
    @State private var title: String = ""
    @State private var content: String = "Content (optional)"
    @State private var contentClicked = false
    @State private var withImageClicked = false
    @State private var anonymous = true
    
    @State private var isLoading = false
    @State private var onEditing = false
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        postImage = inputImage
    }
    
    func clear() {
        self.title = ""
        self.content = ""
        self.imageData = Data()
        self.postImage = nil
    }
    
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.alertTitle = "Oh No"
            self.showingAlert = true
            self.clear()
            return
        }
        
        self.isLoading = true
        
        DataBaseService.uploadPost(university: universityName, motherBoard: motherBoardName, board: boardName, title: title, content: content, imageData: imageData, anonymous: anonymous, onSuccess: {
            self.isLoading = false
            self.alertTitle = "Great!"
            self.error = "Successfuly uploaded it!"
            self.showingAlert = true
            self.clear()
        }) {
            (errorMessage) in
            self.isLoading = false
            self.alertTitle = "Oh No"
            self.error = errorMessage
            self.showingAlert = true
            return

        }
        
        self.clear()
        self.onEditing = false
    }
    
    func errorCheck() -> String? {
        
        if !NetworkService.shared.isConnected {
            return "Please connect to the Internet"
        }
        
        if title.isEmpty {
            return "Please add a title"
        }
        
        //        if (imageData.isEmpty || content.isEmpty) {
        //            return "Please provide an image or write a content"
        //        }
        
        return nil
    }
    
    var body: some View {
        if NetworkService.shared.isConnected {
            ZStack{
                VStack {
                    VStack {
                        HStack(alignment: .center) {
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.primary)
                                
                                Text("PHOTO")
                                    .frame(height: 10)
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                            }
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                        }
                        .padding(.bottom, 3)
                    }
                    .padding(.top)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    HStack {
                        TextField("Title (required)", text: $title, onEditingChanged: { isEditing in
                            self.onEditing = true
                        })
                        .disableAutocorrection(true)
                        
                    }
                    .padding()
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    
                    TextEditor(text: $content)
                        .foregroundColor(contentClicked == false ? Color(UIColor.placeholderText) : .primary)
                        .onTapGesture{
                            if contentClicked == false {
                                self.content = ""
                                contentClicked = true
                            }
                        }
                        .disableAutocorrection(true)
                        .padding()
                    
                    if postImage != nil {
                        HStack{
                            postImage!.resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    Spacer()
                }
                if self.isLoading {
                    LoadingView()
                }
            }
            .navigationBarItems(trailing:
                                    Group{
                                        if onEditing {
                                            Button(action: {
                                                hideKeyboard()
                                                self.onEditing = false
                                            }
                                            , label: {
                                                Text("Done")
                                                    .foregroundColor(.primary)
                                            })
                                        } else {
                                            Button(action: uploadPost, label: {
                                                Text("Post")
                                                    .foregroundColor(.primary)
                                            })
                                        }})
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text(""), buttons: [
                    .default(Text("Choose A Photo")) {
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },
                    .default(Text("Take A Photo")) {
                        self.sourceType = .camera
                        self.showingImagePicker = true
                    },
                    .cancel()
                ])
            }
        } else {
            Text("Please connect to the Internet")
        }
    }
}

//struct UploadPost_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPost(schoolName: <#String#>, motherBoardName: <#String#>, boardName: <#String#>)
//    }
//}
