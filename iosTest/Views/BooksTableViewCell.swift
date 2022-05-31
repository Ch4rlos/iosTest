//
//  BooksTableViewCell.swift
//  iosTest
//
//  Created by Carlos Adrián Quiroga Pérez on 30/05/22.
//  Copyright © 2022 Carlos Adrián Quiroga Pérez. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookDescriptionLabel: UILabel!
    
    @IBOutlet var bookCoverImage: UIImageView!
    @IBOutlet var importedImage: UIImageView!
    @IBOutlet weak var importedLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: BookCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            authorLabel.text = cellViewModel?.author
            bookDescriptionLabel.text = cellViewModel?.description
            
            if let imageURL = cellViewModel?.coverURL {
                bookCoverImage.load(url: imageURL)
            }
            
            if let isImported = cellViewModel?.imported {
                importedImage.image = UIImage(named: "imported")
                importedLabel.text = "Imported"
                importedLabel.isHidden = !isImported
                importedImage.isHidden = !isImported
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        authorLabel.text = nil
        bookDescriptionLabel.text = nil
    
        bookCoverImage.image = UIImage(named: "bookCover")
        importedImage.image = UIImage(named: "imported")
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
