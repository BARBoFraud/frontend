//
//  NewReport.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct NewReport: View {
    @State private var showNextCom: Bool = false
    @State var webURL: String = ""
    @State var Report = ReportForm()
    @State var selectedImage: UIImage?
    @State private var uploadStatus: String?
    @State private var selectedCategoryID: Int? = nil
    
    @EnvironmentObject var router: Router
    @StateObject private var vm = ReportsController()
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack{
            Color.appBg.ignoresSafeArea()
            
            AppWaves()

            VStack{
                HStack{
                    BackArrowBtn()
                        .padding(.leading, 15)
                    Spacer()
                }
                ScrollView(showsIndicators: false){
                VStack{
                    
                    Text("Nuevo reporte")
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .foregroundColor(.text)
                        .padding(.bottom, 10)
                    VStack {
                        ReportSelector(selectedType: $Report.ReportType, selectedCategoryID: $selectedCategoryID)
                        
                        if(Report.ReportType == "Página de internet"){
                            Title(title: $Report.Title)
                            EnterURL(url: $Report.WebUrl)
                            PageName(pageName: $Report.WebPageName)
                            Description(description: $Report.Description)
                            ImageField(imageKey: $Report.ImageRoute, onImageSelected: { image in
                                selectedImage = image
                            })
                        }
                        if(Report.ReportType == "Red social"){
                            Title(title: $Report.Title)
                            Application(application: $Report.application)
                            UserName(userName: $Report.userName)
                            Description(description: $Report.Description)
                            ImageField(imageKey: $Report.ImageRoute, onImageSelected: { image in
                                selectedImage = image
                            })
                        }
                        if(Report.ReportType == "Mensaje"){
                            Title(title: $Report.Title)
                            PhoneNumber(phoneNumber: $Report.Phone)
                            Application(application: $Report.application)
                            Description(description: $Report.Description)
                        }
                        if(Report.ReportType == "Llamada"){
                            Title(title: $Report.Title)
                            PhoneNumber(phoneNumber: $Report.Phone)
                            Description(description: $Report.Description)
                        }
                        if(Report.ReportType == "Correo electrónico"){
                            Title(title: $Report.Title)
                            Email(email: $Report.Email)
                            Description(description: $Report.Description)
                            ImageField(imageKey: $Report.ImageRoute, onImageSelected: { image in
                                selectedImage = image
                            })
                        }
                    }
                    Spacer()
                    
                    Toggle("Anonimo", isOn: $Report.anonymous)
                        .padding()
                    
                    Button {
                        Task{
                            print("Botón")
                            do{
                                if let image = selectedImage {
                                    await vm.uploadImage(image)
                                }
                                guard let categoryId = selectedCategoryID else {
                                    return
                                }
                                await vm.newReport(
                                    categoryId: categoryId,
                                    title: Report.Title,
                                    description: Report.Description,
                                    url: Report.WebUrl.isEmpty ? nil : Report.WebUrl,
                                    website: Report.WebPageName.isEmpty ? nil : Report.WebPageName,
                                    application: Report.application.isEmpty ? nil : Report.application,
                                    phoneNumber: Report.Phone.isEmpty ? nil : Report.Phone,
                                    userName: Report.userName.isEmpty ? nil : Report.userName,
                                    email: Report.Email.isEmpty ? nil : Report.Email,
                                    anonymous: Report.anonymous)
                                router.push(.home)
                            }
                        }
                    } label: {
                        Label("Enviar reporte", systemImage: "paperplane.fill")
                    }
                    .disabled(!(Report.isComplete && selectedImage != nil))
                    .opacity(Report.isComplete && selectedImage != nil ? 1 : 0.4)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Report.isComplete && selectedImage != nil ? .blueAccent : .gray)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 1, y: 3)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isFocused = false
        }
        .onAppear {
            DispatchQueue.main.async {
                isFocused = true
            }
        }
    }
}

extension NewReport {
    struct ReportForm{
        var ReportType: String = ""
        var WebUrl: String = ""
        var Title: String = ""
        var WebPageName: String = ""
        var application: String = ""
        var userName: String = ""
        var Email: String = ""
        var Phone: String = ""
        var Description: String = ""
        var ImageRoute: String = ""
        var anonymous: Bool = false
        
        var isComplete: Bool {
                    switch ReportType {
                    case "Página de internet":
                        return !WebUrl.isEmpty &&
                               !WebPageName.isEmpty &&
                               !Description.isEmpty &&
                               !Title.isEmpty
                        
                    case "Red social":
                        return !application.isEmpty &&
                               !Description.isEmpty &&
                               !userName.isEmpty &&
                        !Title.isEmpty
                        
                    case "Mensaje":
                        return !Phone.isEmpty &&
                               !Description.isEmpty &&
                        !application.isEmpty &&
                        !Title.isEmpty
                        
                    case "Llamada":
                        return !Phone.isEmpty &&
                               !Description.isEmpty &&
                               !Title.isEmpty
                        
                    case "Correo electrónico":
                        return !Email.isEmpty &&
                               !Description.isEmpty &&
                               !Title.isEmpty
                        
                    default:
                        return false
                    }
                }
    }
}

#Preview {
    NewReport()
}
