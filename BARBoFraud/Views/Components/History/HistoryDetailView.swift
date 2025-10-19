//
//  HistoryDetailView.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import SwiftUI
// TODO
// 1. Agregar la tarjeta de categoria


struct HistoryDetailView: View {
    @StateObject var postVm = PostViewModel()
    @StateObject var historyVm = HistoryViewModel()
    @State private var isEditing = false
    @State private var showEmptyAlert = false
    
    // Edited post values
    @State private var categoryId: Int = 0
    
    @State private var url: String? = nil
    @State private var website: String? = nil
    @State private var application: String? = nil
    @State private var phoneNumber: String? = nil
    @State private var username: String? = nil
    @State private var email: String? = nil
    @State private var imageId: String? = nil

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = ""

    @State private var anonymous: Bool = false
    
    @State private var actor: String = ""
    
    var postId: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewHeader(title: "Post")
            Group {
                if postVm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando Post")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                    
                }else if let error = postVm.errorMessage{
                    VStack{
                        Spacer()
                        Text(error).padding()
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                // Post title
                                if isEditing {
                                    TextField("Título", text: $title)
                                        .font(.system(size: 20, weight: .semibold))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .textInputAutocapitalization(.never)
                                } else {
                                    Text(title)
                                        .font(.system(size: 20, weight: .semibold))
                                }
                                Spacer()
                                // Edit icon
                                Image(systemName: isEditing ? "checkmark.circle.fill" : "square.and.pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundStyle(isEditing ? .green : .blueAccent)
                                    .onTapGesture {
                                        withAnimation(.smooth.speed(5)) {
                                            if isEditing {
                                                // Check if there are empty characters
                                                let emptyFields = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                                actor.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                                description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                                
                                                if emptyFields {
                                                    showEmptyAlert = true
                                                    return
                                                }
                                                
                                                // Assign the actor value to the corresponding variable
                                                switch categoryId {
                                                case 1:
                                                    url = actor
                                                case 2:
                                                    username = actor
                                                case 3:
                                                    phoneNumber = actor
                                                case 4:
                                                    phoneNumber = actor
                                                case 5:
                                                    email = actor
                                                default:
                                                    break
                                                }
                                                
                                                let postUpdate = PostUpdate(
                                                    categoryId: categoryId,
                                                    title: title,
                                                    description: description,
                                                    url: url,
                                                    website: website,
                                                    application: application,
                                                    phoneNumber: phoneNumber,
                                                    username: username,
                                                    email: email,
                                                    imageId: imageId,
                                                    anonymous: anonymous
                                                )
                                                
                                                Task {
                                                    await historyVm.updatePost(post: postUpdate, id: postId)
                                                }
                                            }
                                            isEditing.toggle()
                                        }
                                    }
                            }
                            
                            if (isEditing) {
                                TextField("Actor", text: $actor)
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .textInputAutocapitalization(.never)
                                    .keyboardType({
                                        switch categoryId {
                                        case 1:
                                            return UIKeyboardType.URL
                                        case 2:
                                            return UIKeyboardType.default
                                        case 3:
                                            return UIKeyboardType.phonePad
                                        case 4:
                                            return UIKeyboardType.emailAddress
                                        case 5:
                                            return UIKeyboardType.default
                                        default:
                                            return UIKeyboardType.default
                                        }
                                    }())
                                
                            } else {
                                Text("Actor: \(actor)")
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            
                            if let loadedImage = postVm.image {
                                loadedImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(10)
                            } else if postVm.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                            }
                            
                            // Post description
                            if (isEditing) {
                                TextField("Descripción", text: $description)
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .textInputAutocapitalization(.never)
                            } else {
                                Text(description)
                                    .font(.system(size: 16))
                            }
                            // Post date
                            Text(DateUtils.formatDate(from: postVm.historyPost.createdAt))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .alert("Campos vacíos", isPresented: $showEmptyAlert) {
                            Button("Ok", role: .cancel) {}
                        }
                        
                        Divider()
                    }
                }
            }
            .task {
                do{
                    try await postVm.getHistoryPost(id: postId)
                    actor = PostUtils.getActorHistory(from: postVm.historyPost)
                    
                    // Assign the editable values from postVm.post
                    categoryId = await historyVm.getCategoryId(postVm.historyPost.category)
                    title = postVm.historyPost.title
                    description = postVm.historyPost.description
                    url = postVm.historyPost.url
                    website = postVm.historyPost.website
                    application = postVm.historyPost.application
                    phoneNumber = postVm.historyPost.phoneNumber
                    username = postVm.historyPost.username
                    email = postVm.historyPost.email
                    imageId = postVm.historyPost.image
                    
                    if (postVm.historyPost.image != nil){
                        await postVm.loadImage(from: postVm.historyPost.image!)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    HistoryDetailView(postId: 4)
}
