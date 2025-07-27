//
//  DogBreedsResponse.swift
//  DogBreedExplorer
//
//  Created by Ravikanth  on 7/26/25.
//

import Foundation

struct DogBreedsResponse: Codable {
    let message: [String: [String]]
    let status: String
}
