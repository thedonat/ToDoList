//
//  TodoViewModel.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct ToDoViewModel {
    let days: Daylist
    
    var day: String {
        return days.day
    }
    
    var activity: [Todos] {
        return days.todos
    }
    
    var id: [Todos] {
        return days.todos
    }
}
