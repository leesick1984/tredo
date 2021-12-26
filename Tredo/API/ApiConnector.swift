//
//  ApiConnector.swift
//  Tredo
//
//  Created by Alexander Lee on 25.12.2021.
//

import Foundation

class ApiConnector {
    
    static let shared = ApiConnector()
    
    public func performAPICall<T: Codable>(url: String, expectingReturnType: T.Type, completion: @escaping((Result<T, Error>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, _,  error in
            guard let data = data, error == nil else {
                return
            }
            
            var decodedResult : T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
            } catch {
                decodedResult = nil
                print(error)
            }
            
            guard let result = decodedResult else {
                return
            }
            
            completion(.success(result))
        })
        
        task.resume()
    }
}
