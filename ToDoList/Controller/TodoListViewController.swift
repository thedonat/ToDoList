//
//  ViewController.swift
//  ToDoList
//
//  Created by Burak Donat on 15.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var todoListViewModel: ToDoListViewModel = ToDoListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListViewModel.delegate = self
        todoListViewModel.load()
    }
}

extension TodoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todoListViewModel.cellForRowAt()
        return todoListViewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let vm = todoListViewModel.cellForItem(at: indexPath.row)
        cell.titleLabel.text = vm?.day
        if let char = vm?.day.first {
            cell.letterLabel.text = String(char)
        }
        return cell
    }
}

extension TodoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        todoListViewModel.cellForRow(at: indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.isSelected = true
        }
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
        }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Items"
    }
}
    


extension TodoListViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12 * 3)/2 //some width
        let height = width * 1.5 //ratio
        return CGSize(width: width, height: height)
    }
}

extension TodoListViewController: TodoListViewModelProtocol {
    func didGetDayList() {
        collectionView.reloadData()
    }
    func didGetTodoList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListViewModel.numberOfRowsTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = todoListViewModel.todoList[indexPath.row]?.name
        return cell
    }
}

