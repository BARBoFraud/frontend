//
//  ImageField.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 05/10/25.
//

import SwiftUI
import PhotosUI
import UIKit

struct ImageField: View {
    @State private var expanded: Bool = true
    @Binding var imageKey: String
    @Binding var nextStep: Bool
    var onImageSelected: ((UIImage) -> Void)?
    
    //Para fotos
    @State private var selectedUIImage: UIImage?
    @State private var showCamera = false
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var uploadStatus: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            //Botones para subir foto
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation{
                        expanded.toggle()
                    }
                }) {
                    Image(systemName: expanded ? "chevron.right" : "chevron.down")
                        .font(.title2)
                }
                .foregroundColor(.text)
                
                Button {
                    showCamera = true
                } label: {
                    Label("Cámara", systemImage: "camera.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    Label("Galeria", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            .onChange(of: photoPickerItem) {_, newItem in
                Task{
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data){
                        selectedUIImage = uiImage
                        onImageSelected?(uiImage)
                    }
                }
            }
            .padding(.horizontal)
            
            //Foto seleccionada
            Group {
                if let image = selectedUIImage {
                    ScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding()
                    }
                    .frame(height: 300)
                } else {
                    ContentUnavailableView(
                        "Sin imagen",
                        systemImage: "photo",
                        description: Text("Elige una foto del rollo o toma una con la cámara.")
                    )
                    .padding()
                }
            }
            
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(image: $selectedUIImage)
                .ignoresSafeArea()
        }
        .onChange(of: photoPickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedUIImage = uiImage
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 19)
                //.stroke(Color.blue, lineWidth: 3)
                .frame(width: 300)
        )
        .frame(width: 300)
    }
}


struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(_ parent: CameraPicker) { self.parent = parent }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}


#Preview {
    struct prev: View {
        @State var imageRoute: String = ""
        @State var nextStep: Bool = false
        
        var body: some View {
            ImageField(imageKey: $imageRoute, nextStep: $nextStep)
            }
        }
    return prev()
}
