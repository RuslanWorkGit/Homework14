//
//  NetworkManager.swift
//  Homework14
//
//  Created by Ruslan Liulka on 21.01.2025.
//

import Foundation

func fetchData<T: Decodable>(urlString: ConstantLink, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    
    guard let url = URL(string: urlString.rawValue) else {
        completion(.failure(NSError(domain: "Invalid url", code: -1, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let responseError = error {
            completion(.failure(responseError))
            return
        }
        
        guard let responseData = data else {
            completion(.failure(NSError(domain: "No data recieved", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(type, from: responseData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}
