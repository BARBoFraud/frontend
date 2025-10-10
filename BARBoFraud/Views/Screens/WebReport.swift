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
    
    
    
    var body: some View {
        ZStack{
            Color.landingBg1
                .ignoresSafeArea()
            // Background waves
            AppWaves()
            
            ScrollView(showsIndicators: false){
            VStack{
                Spacer().frame(height: 25)
                Text("Nuevo reporte")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .foregroundColor(.text)
                Spacer().frame(height: 40)
                VStack {
                    ReportSelector(selectedType: $Report.ReportType, nextStep: $showNextCom)
                    
                    if(Report.ReportType == "Página de internet"){
                        ImageField(imageKey: $Report.ImageRoute, nextStep: $showNextCom, onImageSelected: { image in
                            selectedImage = image
                        })
                        EnterURL(url: $Report.WebUrl, nextStep: $showNextCom)
                        PageName(pageName: $Report.WebPageName, nextStep: $showNextCom)
                        Description(description: $Report.Description, nextStep: $showNextCom)
                    }
                }
                .padding(.vertical, 24)
                .background(
                    Rectangle()
                        .foregroundColor(.landingBg2)
                        .cornerRadius(19)
                        .frame(width: 350)
                )
                Spacer()
            }
                if Report.isComplete && selectedImage != nil{
                    Button {
                        Task{
                            do{
                                if let image = selectedImage {
                                    let fileKey = try await uploadImage(image)
                                    Report.ImageRoute = fileKey
                                }
                                let controller = ReportsController(httpClient: HTTPClientReports())
                                try await controller.publishAReport(
                                    categoryID: 1, //Tengo que hacer el fetch al endpoint /v1/categories/list
                                    description: Report.Description,
                                    url: Report.WebUrl.isEmpty ? nil : Report.WebUrl,
                                    website: Report.WebPageName.isEmpty ? nil : Report.WebPageName,
                                    socialMedia: Report.SocialNetwork.isEmpty ? nil : Report.SocialNetwork,
                                    phoneNumber: Report.Phone.isEmpty ? nil : Report.Phone,
                                    userName: Report.userName.isEmpty ? nil : Report.userName,
                                    email: Report.Email.isEmpty ? nil : Report.Email,
                                    anonymous: false,
                                    imageId: Report.ImageRoute)
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
    }
    func uploadImage(_ image: UIImage) async throws -> String{
        guard let url = URL(string: "http://localhost:4000/v1/images/upload"),
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsInR5cGUiOiJhY2Nlc3MiLCJhY3RvciI6InVzZXIiLCJpYXQiOjE3NjAwMzM4NzksImV4cCI6MTc2MDAzNzQ3OX0.o1DlEy7UGw9GTAYb4J3InUttmpbbWJXv3fGPdORAOoY"
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Límite del multipart
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Construcción del body
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"foto.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        let (data, response) = try await URLSession.shared.upload(for: request, from: body)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw URLError(.badServerResponse)
            }
        let decoded = try JSONDecoder().decode(UpLoadImageDTO.self, from: data)
            return decoded.fileKey
        
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
                               !ImageRoute.isEmpty
                        
                    case "Mensaje":
                        return !Phone.isEmpty &&
                               !Description.isEmpty &&
                               !ImageRoute.isEmpty
                        
                    case "Llamada":
                        return !Phone.isEmpty &&
                               !Description.isEmpty
                        
                    case "Correo electrónico":
                        return !Email.isEmpty &&
                               !Description.isEmpty &&
                               !ImageRoute.isEmpty
                        
                    default:
                        return false
                    }
                }
    }
}

#Preview {
    WebReport()
}
