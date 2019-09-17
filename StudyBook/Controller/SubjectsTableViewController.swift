//
//  SubjectsTableViewController.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import UIKit
import RealmSwift

final class SubjectsTableViewController: UITableViewController {
    
    private struct Constants {
        static let navigationBarTitle = "Темы"
        static let cellID = "cellID"
    }

    private var subjects = [Subject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
        fetchData()
    }
    
    // MARK: - funcs

    private func configureNavigationBar() {
        navigationItem.title = Constants.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubject))
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
    }
    
    private func fetchData() {
        guard let subjects = Services.realmDatabase.getSubjects() else {
            self.subjects = []
            return
            
        }
        self.subjects = subjects.compactMap({return $0})
        tableView.reloadData()
    }
    
    private func saveSubject(_ subject: Subject) {
        guard Services.realmDatabase.saveSubject(subject) == true else {
            showError(errorDescription: "Не удалось сохранить тему")
            return
        }
        fetchData()
    }
    
    private func deleteRow(with subject: Subject) {
        guard Services.realmDatabase.deleteSubject(subject) else {
            self.showError(errorDescription: "Не удалось удалить тему")
            return
        }
        fetchData()
    }
    
    // MARK: - objc funcs
    
    @objc private func addSubject() {
        let alertController = UIAlertController(title: "Новая тема", message: "Введите название темы", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Название темы"
        }
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
            return
        }))
        alertController.addAction(UIAlertAction(title: "Принять", style: .default, handler: { (_) in
            if let text = alertController.textFields?[0].text, text.isEmpty {
                return
            } else {
                let subject = Subject()
                subject.name = alertController.textFields![0].text!
                self.saveSubject(subject)
            }
        }))
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row].name
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hintsTableViewController = HintsTableViewController()
        hintsTableViewController.subject = subjects[indexPath.row]
        navigationController?.pushViewController(hintsTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteRow(with: subjects[indexPath.row])
        }
    }

}
