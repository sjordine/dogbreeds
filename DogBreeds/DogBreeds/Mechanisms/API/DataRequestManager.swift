//
//  DataRequestManager.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 19/07/21.
//

import Foundation

struct DataRequestManager {
    
    /// Perform an API get, setting the default parameters (key and JSON as result)
    /// - Parameter url: end-point URL
    /// - Parameter headers: Header additional parameters
    /// - Parameter completion: completion handler for the resulting breed list
    /// -    Parameter result: Resulting data or error
    func get(url: String,
             headers:[String:String] = [:],
             completion: @escaping(_ result: Result<Data,Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        //Create request and default parameters
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        //Aditional parameters
        headers.forEach { (key,value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let session = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            if let error = error {
                completion(.failure(APIError.requestError(error)))
            } else {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.noData))
                }
            }
            
        }
        
        session.resume()
    }
    
}
