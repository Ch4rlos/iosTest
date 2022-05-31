//
//  BooksBestSellersModel.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import Foundation

struct BooksBestSellersModel: Codable {
    let results: ResultsBestSellers
}

// MARK: - Results
struct ResultsBestSellers: Codable {
    let bestSellers: [String]
    
    enum CodingKeys: String, CodingKey {
        case bestSellers = "best_sellers"
    }
}
