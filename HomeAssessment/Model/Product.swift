//
//  Product.swift
//  HomeAssesment
//
//  Created by Liliana Popa on 24.09.2024.
//

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
