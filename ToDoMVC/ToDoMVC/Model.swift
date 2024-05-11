//
//  Model.swift
//  ToDoMVC
//
//  Created by Mr President on 05.05.2024.
//

import UIKit

struct Item {
    var string: String
    var completed: Bool = false
    
    init(string: String) {
        self.string = string
    }
}

class Model {
    
    // MARK: Public properties
    var toDoItems: [Item] = [Item(string: "Breakfast"), Item(string: "Lanch"), Item(string: "Dinner"), Item(string: "Breakfast2")]
    var filteredData = [Item]()
    var isSearching: Bool = false
    var sortedAscending: Bool = true
    
    // MARK: Public methods
    func addItem(itemName: String, isCompleted: Bool = false) {
        toDoItems.append(Item(string: itemName))
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = toDoItems[fromIndex]
        toDoItems.remove(at: fromIndex)
        toDoItems.insert(from, at: toIndex)
    }
    
    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }

    func updateItem(at index: Int, with string: String) {
        toDoItems[index].string = string
    }

    func changeState(at item: Int) -> Bool {
        toDoItems[item].completed = !toDoItems[item].completed
        return toDoItems[item].completed
    }
    
    func sortByTitle() {
        toDoItems.sort() {
            sortedAscending ? $0.string < $1.string : $0.string > $1.string
        }
    }
}
