//
//  BooksStoreModel.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import Foundation

// MARK: - BooksTableViewCellWelcome
struct BooksStoreModel: Codable {
    let results: ResultsBooksStore
}

// MARK: - Results
struct ResultsBooksStore: Codable {
    let books: [Book]
}

// MARK: - Book
struct Book: Codable {
    let isbn, title, author, bookDescription: String
    let genre: Genre
    let img: String
    let imported: Bool
    
    enum CodingKeys: String, CodingKey {
        case isbn, title, author
        case bookDescription = "description"
        case genre, img, imported
    }
}

enum Genre: String, Codable {
    case business = "Business"
    case history = "History"
    case science = "Science"
}
