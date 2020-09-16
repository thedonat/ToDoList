//
//  DataModel.swift
//  ToDoList
//
//  Created by Burak Donat on 15.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    let daylist: [Daylist]
}

struct Daylist: Codable {
    let day: String
    let todos: [Todos]
}

struct Todos: Codable {
    let id: Int
    let name: String
}

