//
//  BreedDetailView.swift
//  DogBreedExplorer
//
//  Created by Ravikanth  on 7/26/25.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: String
    @State private var imageURL: String?
    @EnvironmentObject var viewModel: DogBreedsViewModel
    
    var body: some View {
        VStack {
            if let imageURL = imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    switch image {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        ProgressView()
                    }
                }
            } else {
                ProgressView()

            }
            Text(breed.capitalized)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .onAppear {
            viewModel.fetchImage(for: breed) { url in
                self.imageURL = url
            }
        }
        .navigationTitle(breed.capitalized)
    }
}

#Preview {
    BreedDetailView(breed: "caucasian")
}
