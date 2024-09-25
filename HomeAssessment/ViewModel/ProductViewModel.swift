//
//  ProductViewModel.swift
//  HomeAssesment
//
//  Created by Liliana Popa on 24.09.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    
    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func toggleFavorite(product: Product) {
           if let index = favorites.firstIndex(where: { $0.id == product.id }) {
               favorites.remove(at: index)
           } else {
               favorites.append(product)
           }
       }
       
       func isFavorite(product: Product) -> Bool {
           return favorites.contains(where: { $0.id == product.id })
       }
}
