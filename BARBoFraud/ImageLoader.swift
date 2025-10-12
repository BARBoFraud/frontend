//
//  ImageLoader.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/11.
//

import Foundation
import SwiftUI

@MainActor
final class ImageLoader{

    func load(from url: URL) async -> Image{
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        return Image(.fallback)
    }
}
