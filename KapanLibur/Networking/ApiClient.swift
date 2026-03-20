//
//  ApiClient.swift
//  KapanLibur
//
//  Created by Elvis on 19/03/26.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: T
}

class ApiClient {
    let baseUrl: String = "https://kapanlibur-api.krisdev.my.id"
    
    func get<T: Decodable>(path: String) async throws -> ApiResponse<T> {
        let base = URL(string: baseUrl)
        
        guard let url = URL(string: path, relativeTo: base) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(ApiResponse<T>.self, from: data)
    }
}
