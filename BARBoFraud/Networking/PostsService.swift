//
//  PostsService.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import Foundation

struct PostsService{
    func GetPosts() async throws -> PostResponse{
        return PostResponse(post: Post(id: 1, firstName: "Diego", lastName: "Herrera", title: "Nuevo post", postText: "sadfsdaf", image: nil, date: Date.now, likeCount: 1, commentCount: 0));
    }
    
}
/*
func UserRegistration(name:String, email:String, password:String) async throws -> RegistrationFormResponse{
    let requestForm = RegistrationFormRequest(name:name, email:email, password:password)
    let url = URL(string: "http://localhost:3000/users")!
    var httpRequest = URLRequest(url: url)
    httpRequest.httpMethod = "POST"
    httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    httpRequest.httpBody = try? JSONEncoder().encode(requestForm)
    let (data, res) = try await URLSession.shared.data(for: httpRequest)
    print("data: \(res)")
    let response = try JSONDecoder().decode(RegistrationFormResponse.self, from: data)
    return response
}

func UserLogin(email: String, password: String) async throws ->  LoginResponse{
    let requestForm = LoginRequest(email: email, password: password)
    let url = URL(string: "http://localhost:3000/auth/login")!
    var httpRequest = URLRequest(url: url)
    httpRequest.httpMethod = "POST"
    httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    httpRequest.httpBody = try? JSONEncoder().encode(requestForm)
    let (data, _) = try await URLSession.shared.data(for: httpRequest)
    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
    return response
}*/
