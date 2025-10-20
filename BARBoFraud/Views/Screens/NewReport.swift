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
    @State var selectedImage: UIImage?
    @State var imageSelected: Bool = false
    @State private var uploadStatus: String?
    @State var Report = ReportForm()
    
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
                        ReportType(selectedCategoryID: $Report.reportCategoryID)
                        switch (Report.reportCategoryID){
                        case 5:
                            ReportTextField(text: $Report.title, label: "Título", placeholder: "Título del reporte")
                            ReportTextField(text: $Report.email, label: "Correo electrónico", placeholder: "Dirección de correo electrónico", keyboardType: .emailAddress)
                            ReportTextField(text: $Report.description, label: "Descripción", placeholder: "Descripción de lo sucedido", fieldType: .multiLine)
                            ImageField(imageKey: $Report.imageRoute, onImageSelected: { image in
                                selectedImage = image
                                imageSelected = true
                            })
                        case 4:
                            ReportTextField(text: $Report.title, label: "Título", placeholder: "Título del reporte")
                                .onAppear(){
                                    imageSelected = true
                                }
                            ReportTextField(text: $Report.phone, label: "Número telefónico", placeholder: "Número telefónico a reportar", keyboardType: .phonePad)
                            ReportTextField(text: $Report.description, label: "Descripción", placeholder: "Descripción de lo sucedido", fieldType: .multiLine)
                        case 3:
                            ReportTextField(text: $Report.title, label: "Título", placeholder: "Título del reporte")
                            ReportTextField(text: $Report.phone, label: "Número telefónico", placeholder: "Número telefónico a reportar", keyboardType: .phonePad)
                            ApplicationField(application: $Report.application,  title: "Medio de contacto", appType: .messageApp)
                            ReportTextField(text: $Report.description, label: "Descripción", placeholder: "Descripción de lo sucedido", fieldType: .multiLine)
                            ImageField(imageKey: $Report.imageRoute, onImageSelected: { image in
                                selectedImage = image
                                imageSelected = true
                            })
                        case 1:
                            ReportTextField(text: $Report.title, label: "Título", placeholder: "Título del reporte")
                            ReportTextField(text: $Report.webUrl, label: "URL", placeholder: "Dirección URL del sitio web")
                            ReportTextField(text: $Report.pageName, label: "Nombre del sitio", placeholder: "Nombre del sitio web")
                            ReportTextField(text: $Report.description, label: "Descripción", placeholder: "Descripción de lo sucedido", fieldType: .multiLine)
                            ImageField(imageKey: $Report.imageRoute, onImageSelected: { image in
                                selectedImage = image
                                imageSelected = true
                            })
                        case 2:
                            ReportTextField(text: $Report.title, label: "Título", placeholder: "Título del reporte")
                            ApplicationField(application: $Report.application, title: "Red social", appType: .socialMedia)
                            ReportTextField(text: $Report.username, label: "Nombre de usuario", placeholder: "Nombre de usuario")
                            ReportTextField(text: $Report.description, label: "Descripción", placeholder: "Descripción de lo sucedido", fieldType: .multiLine)
                            ImageField(imageKey: $Report.imageRoute, onImageSelected: { image in
                                selectedImage = image
                                imageSelected = true
                            })
                        default:
                            EmptyView()
                        }
                    }.padding()
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            withAnimation {
                                Report.anonymous.toggle()
                                print(Report.anonymous)
                            }
                        }) {
                            Image(systemName: Report.anonymous ? "checkmark.square.fill" : "square")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                        Text("Realizar el reporte de manera anónima")
                    }.padding()
                    
                    Button {
                        Task{
                            do{
                                if let image = selectedImage {
                                    await vm.uploadImage(image)
                                }
                                await vm.newReport(
                                    categoryID: Report.reportCategoryID,
                                    title: Report.title,
                                    description: Report.description,
                                    url: Report.webUrl.isEmpty ? nil : Report.webUrl,
                                    website: Report.pageName.isEmpty ? nil : Report.pageName,
                                    application: Report.application.isEmpty ? nil : Report.application,
                                    phoneNumber: Report.phone.isEmpty ? nil : Report.phone,
                                    userName: Report.username.isEmpty ? nil : Report.username,
                                    email: Report.email.isEmpty ? nil : Report.email,
                                    anonymous: Report.anonymous)
                                router.push(.home)
                            }
                        }
                    } label: {
                        Label("Enviar reporte", systemImage: "paperplane.fill")
                    }
                    .disabled(!(Report.isComplete && imageSelected))
                    .opacity(Report.isComplete && imageSelected ? 1 : 0.4)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Report.isComplete && imageSelected ? .blueAccent : .gray)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 1, y: 3)
                }.padding(.top, 55)
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
        var reportCategoryID: Int = 0
        var webUrl: String = ""
        var title: String = ""
        var pageName: String = ""
        var application: String = ""
        var username: String = ""
        var email: String = ""
        var phone: String = ""
        var description: String = ""
        var imageRoute: String = ""
        var anonymous: Bool = false
        
        var isComplete: Bool {
            switch reportCategoryID {
            case 1:
                return !webUrl.isEmpty &&
                       !pageName.isEmpty &&
                       !description.isEmpty &&
                       !title.isEmpty
                
            case 2:
                return !application.isEmpty &&
                       !description.isEmpty &&
                       !username.isEmpty &&
                       !title.isEmpty
                
            case 3:
                return !phone.isEmpty &&
                       !description.isEmpty &&
                       !application.isEmpty &&
                       !title.isEmpty
                
            case 4:
                return !phone.isEmpty &&
                       !description.isEmpty &&
                       !title.isEmpty
                
            case 5:
                return !email.isEmpty &&
                       !description.isEmpty &&
                       !title.isEmpty
                
            default:
                return false
            }
        }
    }
}

#Preview {
    NewReport()
}
