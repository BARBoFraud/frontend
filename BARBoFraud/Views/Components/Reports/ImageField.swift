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
    @State private var isExpanded: Bool = true
    @Binding var imageKey: String
    var onImageSelected: ((UIImage) -> Void)?
    
    @State private var selectedUIImage: UIImage?
    @State private var showCamera = false
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var uploadStatus: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Button(action: {
                    withAnimation{
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 20, height: 12)
                        .rotationEffect(.degrees(isExpanded ? -90 : 0))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .foregroundColor(.text)
                
                Text("Imagen")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                HStack{
                    PhotosPicker(selection: $photoPickerItem, matching: .images) {
                        Label("Galeria", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .onChange(of: photoPickerItem) {_, newItem in
                        Task{
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data){
                                selectedUIImage = uiImage
                                onImageSelected?(uiImage)
                            }
                        }
                    }
                }
                
                Group {
                    if let image = selectedUIImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding()
                    } else {
                        ContentUnavailableView(
                            "Sin imagen",
                            systemImage: "photo",
                            description: Text("Elige una imagen")
                        )
                        .frame(height: 200)
                    }
                }
            }
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
                .stroke(Color.accentColor, lineWidth: 1)
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
        
        var body: some View {
            ImageField(imageKey: $imageRoute)
            }
        }
    return prev()
}
