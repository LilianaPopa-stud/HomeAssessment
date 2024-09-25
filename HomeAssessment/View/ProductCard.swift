//
//  ProductCard.swift
//  HomeAssessment
//
//  Created by Liliana Popa on 24.09.2024.
//

import SwiftUI

struct ProductCard: View {
    @ObservedObject var viewModel: ProductViewModel
    let product: Product
    var body: some View {
        ZStack{
            ZStack(alignment:.topTrailing){
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                VStack(spacing: 0) {
                    ZStack(alignment: .center ){
                        AsyncImage(url: URL(string: product.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 129, height: 65)
                                    .padding()
                            } else if phase.error != nil {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                            } else {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    .frame(height: 100)
                    
                    VStack(alignment: .leading) {
                        
                        Text(product.title)
                            .font(.custom("font-Bilo", size: 16))
                        Spacer()
                        Text(product.description)
                            .font(.custom("font-Bilo", size: 13))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        
                        Text(String(format: "$%.2f", product.price))
                            .font(.custom("font-Bilo", size: 14))
                        
                    }
                    .frame(height: 85)
                    .padding(.horizontal,15)
                    .padding(.top, 15)
                }
                Button(action: {
                    viewModel.toggleFavorite(product: product)
                }) {
                    Image(systemName: viewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                        .frame(width: 20, height: 18)
                        .offset(x: -15, y: 15)
                }
                .foregroundColor(.black)
            }
            
        }
        .frame(width: 160, height: 215)
    }
}

#Preview {
    ProductCard(viewModel: ProductViewModel(), product: Product(id: 1, title: "Nike", price: 99.99, description: "Air Force 1 Jester XX Black Sonic Yellow", category: "Category", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.5, count: 100)))
}
