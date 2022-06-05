//
//  ViewController.swift
//  Contacts
//
//  Created by Андрей Русин on 16.05.2022.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var contacts: [ContactProtocol] = [] {
        didSet {
            self.contacts.sort {$0.title < $1.title}
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
//    private func loadContacts(){
//        contacts.append(Contact(title: "Мой Номер", phone: "+79175046392"))
//        contacts.append(Contact(title: "Машунька", phone: "+79251898089"))
//        contacts.append(Contact(title: "Мой Номер", phone: "+78005552525"))
//    }
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(title: "Новый контакт", message: "Введите имя и номер телефона", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
            alertController.addTextField { textField in
                textField.placeholder = "Номер телефона"
                let createAddButton = UIAlertAction(title: "Добавить", style: .default) { _ in
                    guard let contactName = alertController.textFields?[0].text,
                          let contactPhone = alertController.textFields?[1].text
                    else {return}
                    let contact = Contact(title: contactName, phone: contactPhone)
                    self.contacts.append(contact)
                    self.tableView.reloadData()
                }
            let createCancelButton = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
            alertController.addAction(createAddButton)
            alertController.addAction(createCancelButton)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
}
    extension ViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contacts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: UITableViewCell
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIdentifier"){
                cell = reuseCell
            } else {
                cell = UITableViewCell(style: .default, reuseIdentifier: "ContactCellIdentifier")
            }
            configure(cell: &cell, for: indexPath)
            return cell
        }
        private func configure(cell: inout UITableViewCell, for indexPath: IndexPath){
            var configuration = cell.defaultContentConfiguration()
            configuration.text = contacts[indexPath.row].title
            configuration.secondaryText = contacts[indexPath.row].phone
            cell.contentConfiguration = configuration
        }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in
                self.contacts.remove(at: indexPath.row)
                tableView.reloadData()
            }
            let actions = UISwipeActionsConfiguration(actions: [deleteAction])
            return actions
        }
    }
