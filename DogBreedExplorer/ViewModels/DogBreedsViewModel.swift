//
//  DogBreedsViewModel.swift
//  DogBreedExplorer
//
//  Created by Ravikanth  on 7/26/25.
//

import Foundation

class DogBreedsViewModel: ObservableObject
{
    @Published var breeds: [String] = []
    
    func fetchBreeds() {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data , error == nil else { return }
            
            do {
                let decode = try JSONDecoder().decode(DogBreedsResponse .self, from: data)
                DispatchQueue.main.async {
                    self.breeds = decode.message.keys.sorted()
                }
            } catch {
                print("Decoding Error: \(error)")
            }
            
        }.resume()
    }
    
    func fetchImage(for breed:String, completion: @escaping (String?) -> Void) {
        let urlString = "https://dog.ceo/api/breed/\(breed)/images/random"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            guard let data = data , error == nil else {
                completion(nil)
                return
            }
            
            if let decoded = try? JSONDecoder().decode(DogImageResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded.message)
                }
            }
        }.resume()
    }
    
}
