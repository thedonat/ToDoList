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
    
    override var isSelected: Bool {
        didSet {
            if isSelected { // Selected cell
                self.backgroundColor = UIColor.purple
            } else { // Normal cell
                self.backgroundColor = UIColor.white
           }
        }
    }
    
    override func awakeFromNib() {
        dayView.layer.cornerRadius = 10
    }
}
