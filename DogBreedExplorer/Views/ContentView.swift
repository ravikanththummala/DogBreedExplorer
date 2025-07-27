//
//  ContentView.swift
//  DogBreedExplorer
//
//  Created by Ravikanth  on 7/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DogBreedsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.breeds, id: \.self) { breed in
                NavigationLink(destination:
                                BreedDetailView(breed: breed) .environmentObject(viewModel)) {
                    Text(breed.capitalized)
                }
            }
            .navigationTitle("Dog Breeds")
            .onAppear {
                viewModel.fetchBreeds()
            }
        }
    }
}

#Preview {
    ContentView()
}
