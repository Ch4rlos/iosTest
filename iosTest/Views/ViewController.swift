//
//  ViewController.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 29/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    lazy var viewModel = {
        BooksViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(BooksTableViewCell.nib, forCellReuseIdentifier: BooksTableViewCell.identifier)
    }
    
    func initViewModel() {
        //viewModel.getBestSellers()
        viewModel.getBooks()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.bookCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = [Genre.business.rawValue, Genre.history.rawValue, Genre.science.rawValue]
        return titles[section]
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookCellViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as? BooksTableViewCell else { fatalError("xib does not exists") }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
