//
//  ViewController.swift
//  ToDoMVC
//
//  Created by Mr President on 05.05.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortingTasksButton: UIBarButtonItem!
    
    var customCell = CustomCell()
    var model = Model()
    var searchController = UISearchController()
    var alertController = UIAlertController()
    
    
    // MARK: Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Find your task..."
        
        navigationItem.searchController = searchController
        navigationItem.title = "Tasks"
    }
    
    // MARK: @IBActions
    @IBAction func addTaskButtonAction(_ sender: UIBarButtonItem) {
        alertController = UIAlertController(title: "Create new task", message: "Enter your new task. Swipe to the left to edit your task and swipe to the right to delete.", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Put your task here"
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        // Логика добавления через алерт контроллер
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (createAlert) in
            guard let unwrTextFieldValue = self.alertController.textFields?[0].text else { return }
            self.model.addItem(itemName: unwrTextFieldValue)
            self.model.sortByTitle()
            self.tableView.reloadData()
        }
        
        // Логика отмены алерт конроллера
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAlertAction)
        alertController.addAction(createAlertAction)
        present(alertController, animated: true, completion: nil)
        createAlertAction.isEnabled = false
    }
    
    @IBAction func sortingTasksButtonAction(_ sender: UIBarButtonItem) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        model.sortedAscending = !model.sortedAscending
        sortingTasksButton.image = model.sortedAscending ? arrowUp : arrowDown
        model.sortByTitle()
        tableView.reloadData()
    }
    
    
    // MARK: DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.isSearching {
            return model.filteredData.count
        } else {
            return model.toDoItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        let currentItem = model.toDoItems[indexPath.row]
        if model.isSearching {
            cell.label.text = model.filteredData[indexPath.row].string
        } else {
            cell.labelText = currentItem.string
        }
        cell.accessoryType = currentItem.completed ? .checkmark : .none
        return cell
    }
    
    // Отметка "выполнено" при касании на задачу
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if model.changeState(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    // Возможность менять ячейки местами для работы сортировки
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        model.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
    // Возможность свайпа влево
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Удаление при свайпе влево
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            model.toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // Свайп вправо для изменения
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal,
                                            title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editCellContent(indexPath: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func editCellContent(indexPath: IndexPath) {
        let cell = tableView(tableView, cellForRowAt: indexPath) as! CustomCell
        alertController = UIAlertController(title: "Edit your task", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField.text = cell.labelText
        })
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let editAlertAction = UIAlertAction(title: "Submit", style: .default) { (createAlert) in
            guard let textFields = self.alertController.textFields, textFields.count > 0 else { return }
            guard let textValue = self.alertController.textFields?[0].text else { return }
            self.model.updateItem(at: indexPath.row, with: textValue)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAlertAction)
        alertController.addAction(editAlertAction)
        present(alertController, animated: true, completion: nil)
    }
        
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        guard let senderText = sender.text, alertController.actions.indices.contains(1) else { return }
        let action = alertController.actions[1]
        action.isEnabled = senderText.count > 0
    }
    
}


// MARK: Extensions
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        model.filteredData.removeAll()  // удаление предыдущих результатов
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        for item in model.toDoItems {
            let text = searchText.lowercased()
            let isArrayContais = item.string.lowercased().range(of:  text)
            
            if isArrayContais != nil {
                print("search completed")
                model.filteredData.append(Item(string: item.string))
                print(model.filteredData )
            }
        }
        print(model.filteredData.isEmpty)
        if searchBar.text == "" {
            model.isSearching = false
            tableView.reloadData()
        } else {
            model.isSearching = true
            model.filteredData = model.toDoItems.filter({$0.string.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
}

extension ViewController: CustomCellDelegate {
    
    // MARK: Cell Protocol Stubs
    func editCell(cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else { return }
        self.editCellContent(indexPath: unwrIndexPath)
    }
    
    func deleteCell(cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else { return }
        model.removeItem(at: unwrIndexPath.row)
        tableView.reloadData()
    }
}
