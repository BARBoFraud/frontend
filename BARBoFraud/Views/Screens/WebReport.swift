//
//  WebReport.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct WebReport: View {
    @State private var showNextCom: Bool = false
    @State var webURL: String = ""
    @State var Report = ReportForm()
    @State var selectedImage: UIImage?
    @State private var uploadStatus: String?
    @State private var selectedCategoryID: Int? = nil
    
    @EnvironmentObject var router: Router
    @StateObject private var vm = ReportsController()
    
    var body: some View {
        ZStack{
            Color.landingBg1
                .ignoresSafeArea()
            // Background waves
            AppWaves()

            ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    BackArrowBtn()
                    Spacer()
                }
                .padding()
                
                Spacer().frame(height: 25)
                Text("Nuevo reporte")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .foregroundColor(.text)
                Spacer().frame(height: 40)
                VStack {
                    ReportSelector(selectedType: $Report.ReportType, selectedCategoryID: $selectedCategoryID, nextStep: $showNextCom)
                    
                    if(Report.ReportType == "Página de internet"){
                        ImageField(imageKey: $Report.ImageRoute, nextStep: $showNextCom, onImageSelected: { image in
                            selectedImage = image
                        })
                        EnterURL(url: $Report.WebUrl, nextStep: $showNextCom)
                        PageName(pageName: $Report.WebPageName, nextStep: $showNextCom)
                        Description(description: $Report.Description, nextStep: $showNextCom)
                    }
                    if(Report.ReportType == "Red social"){
                        ImageField(imageKey: $Report.ImageRoute, nextStep: $showNextCom, onImageSelected: { image in
                            selectedImage = image
                        })
                        SocialNetwork(socialNetwork: $Report.SocialNetwork)
                        UserName(userName: $Report.userName)
                        Description(description: $Report.Description, nextStep: $showNextCom)
                    }
                    if(Report.ReportType == "Mensaje" || Report.ReportType == "Llamada"){
                        ImageField(imageKey: $Report.ImageRoute, nextStep: $showNextCom, onImageSelected: { image in
                            selectedImage = image
                        })
                        PhoneNumber(phoneNumber: $Report.Phone)
                        Description(description: $Report.Description, nextStep: $showNextCom)
                    }
                    if(Report.ReportType == "Correo electrónico"){
                        ImageField(imageKey: $Report.ImageRoute, nextStep: $showNextCom, onImageSelected: { image in
                            selectedImage = image
                        })
                        Email(email: $Report.Email)
                        Description(description: $Report.Description, nextStep: $showNextCom)
                    }
                }
                .padding(.vertical, 24)
                .background(
                    Rectangle()
                        .foregroundColor(.landingBg2)
                        .cornerRadius(20)
                        .frame(width: 350)
                )
                Spacer()
            }
                if Report.isComplete && selectedImage != nil{
                    Button {
                        Task{
                            do{
                                if let image = selectedImage {
                                    await vm.uploadImage(image)
                                }
                                guard let categoryId = selectedCategoryID else {
                                    print("No se ha seleccionado una categoría.")
                                    return
                                }
                                print("✅ CategoryID seleccionado: \(categoryId)")
                                await vm.newReport(
                                    categoryId: categoryId,
                                    description: Report.Description,
                                    url: Report.WebUrl.isEmpty ? nil : Report.WebUrl,
                                    website: Report.WebPageName.isEmpty ? nil : Report.WebPageName,
                                    socialMedia: Report.SocialNetwork.isEmpty ? nil : Report.SocialNetwork,
                                    phoneNumber: Report.Phone.isEmpty ? nil : Report.Phone,
                                    userName: Report.userName.isEmpty ? nil : Report.userName,
                                    email: Report.Email.isEmpty ? nil : Report.Email,
                                    anonymous: false)
                                router.push(.home)
                            }
                        }
                        
                    } label: {
                        Label("Enviar reporte", systemImage: "paperplane.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
            }.frame(maxWidth: .infinity)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension WebReport {
    struct ReportForm{
        var ReportType: String = ""
        var WebUrl: String = ""
        var WebPageName: String = ""
        var SocialNetwork: String = ""
        var userName: String = ""
        var Email: String = ""
        var Phone: String = ""
        var Description: String = ""
        var ImageRoute: String = ""
        
        var isComplete: Bool {
                    switch ReportType {
                    case "Página de internet":
                        return !WebUrl.isEmpty &&
                               !WebPageName.isEmpty &&
                               !Description.isEmpty
                        
                    case "Red social":
                        return !SocialNetwork.isEmpty &&
                               !Description.isEmpty &&
                               !userName.isEmpty
                        
                    case "Mensaje":
                        return !Phone.isEmpty &&
                               !Description.isEmpty
                        
                    case "Llamada":
                        return !Phone.isEmpty &&
                               !Description.isEmpty
                        
                    case "Correo electrónico":
                        return !Email.isEmpty &&
                               !Description.isEmpty
                        
                    default:
                        return false
                    }
                }
    }
}

#Preview {
    WebReport()
}
