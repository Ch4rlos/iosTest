//
//  BooksViewModel.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import Foundation

class BooksViewModel: NSObject {
    private var bookService: BookStoreServicesProtocol
    
    var reloadTableView: (() -> Void)?
    
    var books = [Book]()
    var bestSellersIds: [String] = []
    
    var bookCellViewModels = [[BookCellViewModel]]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(bookService: BookStoreServicesProtocol = BooksService()) {
        self.bookService = bookService
    }
    
    func fetchData(books: [Book]) {
        self.books = books
        
        var bestSeller = [BookCellViewModel]()
        var science = [BookCellViewModel]()
        var history = [BookCellViewModel]()
        var business = [BookCellViewModel]()
        
        for book in books {
            if bestSellersIds.contains(where: {$0 == book.isbn}) {
                bestSeller.append(createCellModel(book: book))
            } else {
                switch book.genre {
                case .business:
                    business.append(createCellModel(book: book))
                case .history:
                    history.append(createCellModel(book: book))
                case .science:
                    science.append(createCellModel(book: book))
                }
            }
        }
        bookCellViewModels = [bestSeller, business, history, science]
    }
    
    func fetchData(bestSeller: [String]) {
        self.bestSellersIds = bestSeller
    }
    
    func getBooks() {
        bookService.getBooks { success, model, error in
            if success, let model = model {
                let books = model.results.books
                self.fetchData(books: books)
            } else {
                print(error!)
            }
        }
    }
    
    func getBestSellers() {
        bookService.getBestSellers { success, model, error in
            if success, let model = model {
                let bestSellers = model.results.bestSellers
                self.fetchData(bestSeller: bestSellers)
            } else {
                print(error!)
            }
        }
    }

    func createCellModel(book: Book) -> BookCellViewModel {
        let author = book.author
        let description = book.bookDescription
        let coverURL = URL(string: book.img)
        let imported = book.imported
        let title = book.title
        let genre = book.genre
        
        return BookCellViewModel(title: title, author: author, description: description, imported: imported, coverURL: coverURL!, genre: genre)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BookCellViewModel {
        return bookCellViewModels[indexPath.section][indexPath.row]
    }
}
