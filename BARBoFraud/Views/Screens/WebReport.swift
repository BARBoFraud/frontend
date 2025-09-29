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
    var body: some View {
        ZStack{
            Color.landingBg1
                .ignoresSafeArea()
            // Background waves
            AppWaves()
            
            VStack{
                Spacer().frame(height: 25)
                Text("Nuevo reporte")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .foregroundColor(.text)
                Spacer().frame(height: 40)
                VStack {
                    ReportSelector(selectedType: $Report.ReportType)
                    
                    if(Report.ReportType == "Página de internet"){
                        EnterURL(url: $Report.WebUrl, nextStep: $showNextCom)
                    }
                    if showNextCom {
                        PageName(pageName: $Report.WebPageName, nextStep: $showNextCom)
                    }
                    if showNextCom {
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
            
            
        }
    }
}

extension WebReport {
    struct ReportForm{
        var ReportType: String = ""
        var WebUrl: String = ""
        var WebPageName: String = ""
        var SocialNetwork: String = ""
        var Email: String = ""
        var Phone: String = ""
        var Description: String = ""
    }
}

#Preview {
    WebReport()
}
