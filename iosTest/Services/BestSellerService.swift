//
//  BestSellerService.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import Foundation

protocol BestSellersServiceProtocol {
    func getBooks(completion: @escaping (_ success: Bool, _ results: BooksBestSellersModel?, _ error: String?) -> ())
}

class BooksService: BooksBestSellersModel {
    func getBooks(completion: @escaping (Bool, BooksStoreModel?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/ejgteja/files/main/books.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(BooksBestSellersModel.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
