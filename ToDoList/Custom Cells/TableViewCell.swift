//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setView(activity: String?, selected: Bool) {
        activityLabel.text = activity
        if selected {
            checkImageView.image = UIImage(systemName: "checkmark.square")
        } else {
            checkImageView.image = UIImage(systemName: "square")
        }
    }
}
