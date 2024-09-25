//
//  DetailedProductPage.swift
//  HomeAssessment
//
//  Created by Liliana Popa on 24.09.2024.
//

import SwiftUI

struct DetailedProductPage: View {
    @ObservedObject var viewModel: ProductViewModel
    let product: Product
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isExpanded = false
    var body: some View {
            NavigationStack{
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack{
                        Ellipse()
                            .fill(Color.black)
                            .frame(width: 595, height: 595)
                            .offset(y: -410)
                            .ignoresSafeArea(edges: .top)
                        Spacer()
                    }
                    VStack{
                        AsyncImage(url: URL(string: product.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 375, height: 305)
                            }
                        }
                        .padding(.top, 90)
                        
                        VStack(alignment: .leading){
                            ScrollView{
                                HStack
                                {
                                    Text(product.title)
                                        .font(.custom("Montserrat", size: 16))
                                        .fontWeight(.medium)
                                        .padding(.top, 5)
                                    Spacer()
                                    Text(String(format: "$%.2f", product.price))
                                        .font(.custom("Montserrat", size: 20))
                                        .fontWeight(.medium)
                                }
                                .padding(.top,20)
                                
                                Divider()
                                
                                VStack(alignment: .leading){
                                    Text(product.description)
                                        .font(.custom("Montserrat", size: 16))
                                        .fontWeight(.light)
                                        .padding(.top, 5)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(isExpanded ? 10 : 3)
                                    
                                    Button(isExpanded ? "Read less" : "Read more" ) {
                                        isExpanded.toggle()
                                    }
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(Color.black)
                                }
                                .padding(.vertical, 5)
                                
                                Divider()
                                //Rating
                                HStack{
                                    Text("Rating:")
                                        .font(.custom("Montserrat", size: 16))
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text(String(format: "%.1f from %.d reviews", product.rating.rate,product.rating.count))
                                        .font(.custom("Montserrat", size: 15))
                                        .fontWeight(.medium)
                                        .foregroundColor(.orangish)
                                }
                                
                            }
                            .padding(.horizontal,20)
                        }
                        Spacer()
                        Button(action: {
                            //add to cart
                        }) {
                            Text("ADD TO CART")
                                .font(Font.custom("AbhayaLibre-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(width: 335, height: 50) //
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.black))
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.toggleFavorite(product: product)
                        }) {
                            Image(systemName: viewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 29,height: 24)
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 12,height: 24)
                                .foregroundColor(.white)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                
            }
    }
}

#Preview {
    DetailedProductPage(viewModel: ProductViewModel(), product: Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 99.99, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "Category", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.5, count: 100)))
}
