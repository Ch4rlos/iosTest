//
//  BookCellViewModel.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import Foundation

struct BookCellViewModel {
    var title: String
    var author: String
    var description: String
    var imported: Bool
    var coverURL: URL
    var genre: Genre
}
