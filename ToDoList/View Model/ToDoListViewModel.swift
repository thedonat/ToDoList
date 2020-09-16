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
}

struct ToDoListViewModel {
    weak var delegate: TodoListViewModelProtocol?
    var daylist: [Daylist?] = []
    var todoList: [Todos?] = []
    var numberOfRows: Int {
        return daylist.count
    }
    var numberOfRowsTable: Int {
        return todoList.count
    }
    
    mutating func cellForRow(at index: Int) -> [Todos]?{
        if let todos = daylist[index]?.todos {
            self.todoList = todos
            self.delegate?.didGetTodoList()
            return todos
        }
        return nil
    }
    
    func cellForItem(at index: Int) -> ToDoViewModel? {
        if let day = self.daylist[index] {
            return ToDoViewModel(days: day)
        }
        return nil
    }
    
    mutating func cellForRowAt() {
        if let todos = daylist[0]?.todos {
            self.todoList = todos
            self.delegate?.didGetTodoList()
        }
    }
    
    
    mutating func load() {
        if let fileLocation = Bundle.main.url(forResource: "myData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode(DataModel.self, from: data)
                self.daylist = decodedData.daylist
                self.delegate?.didGetDayList()
                print(decodedData)
            } catch  {
                print("error")
            }
        }
    }
}

struct ToDoViewModel {
    let days: Daylist
    var day: String {
        return days.day
    }
    var name: [Todos] {
        return days.todos
    }
    var id: [Todos] {
        return days.todos
    }
}
