//
//  ViewController.swift
//  ToDoList
//
//  Created by Burak Donat on 15.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var result = [Daylist]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.result = DataLoader().dataModel
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = result[indexPath.row].day
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12 * 3)/2 //some width
        let height = width * 1.5 //ratio
        return CGSize(width: width, height: height)
    }
}
