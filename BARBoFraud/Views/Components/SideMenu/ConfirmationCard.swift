//
//  ConfirmationCard.swift
//  BARBoFraud
//
//  Created by Barbie on 30/09/25.
//

import SwiftUI

struct ConfirmationCard: View {
    @Binding var isPresented: Bool

    let title: String
    let confirmLabel: String
    let cancelLabel: String
    let confirmAction: () async -> Void

    init(
        isPresented: Binding<Bool>,
        title: String,
        confirmLabel: String = "Sí",
        cancelLabel: String = "No",
        confirmAction: @escaping () async -> Void
    ) {
        self._isPresented = isPresented
        self.title = title
        self.confirmLabel = confirmLabel
        self.cancelLabel = cancelLabel
        self.confirmAction = confirmAction
    }
    
    private func confirmAndClose() async {
        await confirmAction()
        withAnimation { isPresented = false }
    }

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isPresented = false }
                    }

                VStack(spacing: 16) {
                    Text(title)
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.text)

                    Spacer().frame(height: 10)

                    HStack(spacing: 12) {
                        Button(action: {
                            Task {
                                await confirmAndClose()
                            }
                        }) {
                            Text(confirmLabel)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("BtnColor"))
                                )
                                .foregroundColor(.black)
                        }
                        .shadow(radius: 1)
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            withAnimation { isPresented = false }
                        }) {
                            Text(cancelLabel)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("Tarjeta"))
                                )
                        }
                        .buttonStyle(.plain)
                        

                        
                    }
                }
                .padding(20)
                .frame(maxWidth: 340)
                .background(.appBg)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(radius: 4)
                .padding(.horizontal, 20)
                .transition(.scale.combined(with: .opacity))
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
        }
    }
}





#Preview {
    ConfirmationCard(isPresented: .constant(true), title: "¿Seguro que deseas contactar con la policía cibernética?", confirmAction: {})
}
