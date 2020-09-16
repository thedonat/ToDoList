//
//  Daylist.swift
//  ToDoList
//
//  Created by Burak Donat on 16.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct Daylist: Codable {
    let day: String
    let todos: [Todos]
}
