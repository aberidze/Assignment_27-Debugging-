//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    public init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        // FIXME: url-ის ნაცვლად იყო ცარიელი სტრინგი
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                // FIXME: არ უნდა იყოს Thread-ის ნაწილი
                // DispatchQueue.main.async { completion(.failure(error)) }
                completion(.failure(error))
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
}


