//
//  DayViewModel.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct DayListViewModel {
    let day
}

struct ToDoListViewModel {
    let daylist: Daylist
    var day: String {
        return daylist.day
    }
    var name: [Todos] {
        return daylist.todos
    }
    var id: [Todos] {
        return daylist.todos
    }
}
