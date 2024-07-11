//
//  Model.swift
//  Exam
//
//  Created by Alexander Suprun on 09.07.2024.
//

import Foundation

enum ProductModel: Hashable {
    
    enum Section: Int, CaseIterable {
        case product
    }
        

    struct Rating: Codable, Hashable {
        let rate: Double
        let count: Int
    }

    struct Product: Codable, Hashable {
        let id: Int
        let title: String
        let price: Double
        let description: String
        let category: String
        let image: String
        let rating: Rating
    }
}

