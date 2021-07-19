//
//  APIError.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 19/07/21.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestError(Error)
    case noData
}
