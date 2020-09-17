//
//  ViewController.swift
//  ToDoList
//
//  Created by Burak Donat on 15.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    //MARK: Properites
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var todoListViewModel: TodoListViewModel = TodoListViewModel()
    private var selectedCellIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() //Deleting separators between empty rows
        getData()
    }
    
    //MARK: Helpers
    private func getData() {
        todoListViewModel.delegate = self
        todoListViewModel.loadData()
    }
    private func handleError() {
        errorLabel.isHidden = false
        errorLabel.text = K.errorText
    }
}

//MARK: UICollectionViewDataSource
extension TodoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoListViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionIdentifier, for: indexPath) as! CollectionViewCell
        let vm = todoListViewModel.getDayItem(at: indexPath.row)
        cell.setView(title: vm?.day)
        
        if indexPath == selectedCellIndexPath {
            cell.setSelectedCell(true)
        } else {
            cell.setSelectedCell(false)
        }
        
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension TodoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: selectedCellIndexPath) as? CollectionViewCell
        selectedCell?.setSelectedCell(false)
        
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.setSelectedCell(true)
        self.selectedCellIndexPath = indexPath
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        todoListViewModel.getTodoCell(at: indexPath.row)
    }
}

//MARK: UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableIdentifier, for: indexPath) as! TableViewCell
        if let vm = todoListViewModel.getTodoList(at: indexPath.row) {
            let isSelected = todoListViewModel.selecteds.contains(vm.id)
            cell.setView(activity: vm.activity,
                         selected: isSelected)
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = todoListViewModel.getTodoList(at: indexPath.row)?.id {
            todoListViewModel.handleSelection(with: id)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return K.sectionHeader
    }
}

//MARK: TodoListViewModelProtocol
extension TodoListViewController: TodoListViewModelProtocol {
    func didFailWithError() {
        handleError()
    }
    
    func didGetDayList() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        todoListViewModel.getTodoCell(at: 0)
        todoListViewModel.getSelecteds()
    }
    
    func didGetTodoList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
