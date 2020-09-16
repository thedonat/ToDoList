//
//  CollectionViewCell.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dayView.layer.cornerRadius = 10
    }
    
    func setView(title: String?) {
        titleLabel.text = title
        if let char = title?.first {
            letterLabel.text = String(char)
        }
    }
    
    func setSelectedCell(_ selected: Bool) {
        if selected {
             dayView.layer.borderWidth = 5
         } else {
             dayView.layer.borderWidth = 0
        }
    }
}
