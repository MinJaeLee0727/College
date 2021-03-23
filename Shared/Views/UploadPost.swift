//
//  UploadPost.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/21.
//

import SwiftUI

struct UploadPost: View {
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
    
    @State private var isLoading = false
    
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
            self.showingAlert = true
            self.clear()
            return
        }
        
        self.isLoading = true
        
        PostService.uploadPostWithImage(title: title, content: content, imageData: imageData, onSuccess: {
            self.isLoading = false
            self.error = "Successfuly uploaded it!"
            self.showingAlert = true
            self.clear()
        }) {
            (errorMessage) in
            self.isLoading = false
            self.error = errorMessage
            self.showingAlert = true
            return
             
        }
        
        self.clear()
    }
    
    func errorCheck() -> String? {
        if title.isEmpty {
            return "Please add a title"
        }
        
        //        if (imageData.isEmpty || content.isEmpty) {
        //            return "Please provide an image or write a content"
        //        }
        
        return nil
    }
    
    var body: some View {
        ZStack{
            VStack {
                VStack {
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        })
                        
                        Spacer()
                        
                        Button(action: uploadPost, label: {
                            Text("Post")
                                .foregroundColor(.black)
                            
                        })
                    }
                    .padding()
                    
                    HStack(alignment: .center) {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.black)
                            
                            Text("PHOTO")
                                .frame(height: 10)
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                    }
                    .padding(.bottom, 3)
                }
                
                Divider()
                
                HStack {
                    TextField("Title (required)", text: $title)
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
    }
}

struct UploadPost_Previews: PreviewProvider {
    static var previews: some View {
        UploadPost()
    }
}
