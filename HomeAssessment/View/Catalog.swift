//
//  ContentView.swift
//  HomeAssessment
//
//  Created by Liliana Popa on 24.09.2024.
//

import SwiftUI

struct Catalog: View {
    @ObservedObject var viewModel = ProductViewModel()
    @State private var search = ""
    @State private var isSearching = false
    @State private var displayFavorites = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.custom
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading){
                        HStack {
                            ZStack(alignment: .leading) {
                                TextField("Search product", text: $search, onEditingChanged: { isEditing in
                                    isSearching = isEditing
                                })
                                .padding(10)
                                .padding(.leading, 30)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 0)
                                )
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 10)
                                    Spacer()
                                }
                            }
                        }
                        HStack {
                            Text("Products")
                                .font(.custom("Montserrat", size: 30))
                                .fontWeight(.heavy)
                                .padding(.top, 20)
                            Spacer()
                            Button(action: {
                                displayFavorites.toggle()
                            }){Image(systemName: displayFavorites ? "heart.fill" : "heart")
                                    .resizable()
                                .frame(width: 35, height: 31)}
                            .offset(x:-5, y: 5)
                        }
                        
                        .foregroundColor(.black)
                        .padding(.vertical, 7)
                        if !displayFavorites {
                            Text("\(viewModel.products.count) products found")
                                .font(.custom("font-Bilo", size: 16))
                        }
                        else {
                            if viewModel.favorites.count == 0 {
                                Text("No favorites yet")
                                    .font(.custom("font-Bilo", size: 16))
                            }
                            else {
                                Text("\(viewModel.favorites.count) favorites")
                                    .font(.custom("font-Bilo", size: 16))
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    if !displayFavorites{
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(viewModel.products.filter { product in
                                search.isEmpty || product.title.localizedCaseInsensitiveContains(search)
                            }) { product in
                                NavigationLink(destination: DetailedProductPage(viewModel: viewModel, product: product)) {
                                    ProductCard(viewModel: viewModel, product: product)
                                }
                                .foregroundStyle(Color.black)
                            }
                        }
                        .padding(20)                    }
                    else {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(viewModel.favorites.filter { favorite in
                                search.isEmpty || favorite.title.localizedCaseInsensitiveContains(search)
                            }) { favorite in
                                NavigationLink(destination: DetailedProductPage(viewModel: viewModel, product: favorite)) {
                                    ProductCard(viewModel: viewModel, product: favorite)
                                }
                                .foregroundStyle(Color.black)
                            }
                        }
                        .padding(20)
                    }
                }
                .onAppear {
                    viewModel.fetchProducts()
                }
            }
        }
    }
}

#Preview {
    Catalog()
}
