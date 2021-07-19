//
//  File.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 19/07/21.
//

import Foundation

struct DogImage: Codable, Identifiable {
    var id: String
    var height: Int
    var width: Int
    var url: String
}
