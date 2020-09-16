//
//  DataLoader.swift
//  ToDoList
//
//  Created by Burak Donat on 15.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

public class DataLoader {
    @Published var dataModel = [Daylist]()
    init() {
        load()
    }
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "myData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode(DataModel.self, from: data)
                self.dataModel = decodedData.daylist
                print(decodedData)
            } catch  {
                print("error")
            }
        }
    }
}
