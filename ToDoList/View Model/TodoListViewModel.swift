//
//  DayViewModel.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol TodoListViewModelProtocol: class {
    func didGetDayList()
    func didGetTodoList()
    func didFailWithError()
}

class TodoListViewModel {
    weak var delegate: TodoListViewModelProtocol?
    
    private let defaults = UserDefaults.standard
    private var daylist: [Daylist?] = []
    private var todoList: [Todos?] = []
    private var selectedIDs: [Int] = []
    
    var numberOfItems: Int {
        return daylist.count
    }
    
    var numberOfRows: Int {
        return todoList.count
    }
    
    var selecteds: [Int] {
        return selectedIDs
    }
    
    func loadData() {
        if let fileLocation = Bundle.main.url(forResource: "myData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let decodedData = try JSONDecoder().decode(DataModel.self, from: data)
                self.daylist = decodedData.daylist
                self.delegate?.didGetDayList()
            } catch  {
                self.delegate?.didFailWithError()
            }
        }
    }
    
    func getTodoCell(at index: Int) { //return tableview cells at index
        if let todos = daylist[index]?.todos {
            self.todoList = todos
            self.delegate?.didGetTodoList()
        }
    }
    
    func getTodoList(at index: Int) -> Todos? {
        return todoList[index]
    }
    
    func getDayItem(at index: Int) -> ToDoViewModel? { //return collectionview items at index
        if let day = self.daylist[index] {
            return ToDoViewModel(days: day)
        }
        return nil
    }
    
    func handleSelection(with id: Int) { // save/remove selected activities to/from the selectedIDs
        if let selecteds = defaults.value(forKey: K.key) as? [Int] {
            self.selectedIDs = selecteds
        }
        
        if !selectedIDs.contains(id) {
            selectedIDs.append(id)
            defaults.set(selectedIDs, forKey: K.key)
        } else {
            selectedIDs = selectedIDs.filter { $0 != id }
            defaults.set(selectedIDs, forKey: K.key)
        }
    }
    
    func getSelecteds() {
        if let selecteds = defaults.value(forKey: K.key) as? [Int] {
            self.selectedIDs = selecteds
        }
    }
}
