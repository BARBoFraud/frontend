//
//  ProfileController.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    private let authController = AuthenticationController()
    
    func getProfile() async -> Profile? {
        do {
            _ = try await authController.ensureAccessToken()
            let profileResponse = try await NetworkManager.shared.userProfileNet()
            return profileResponse
        } catch {
            print("Error al obtener el perfil: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func updateProfile(_ body: UpdateProfile) async {
        do {
            let _ = try await NetworkManager.shared.updateProfile(body)
        } catch {
            print("Error al actualizar el perfil: \(error.localizedDescription)")
        }
    }
}
