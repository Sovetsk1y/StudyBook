//
//  HintsTableViewController.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import UIKit

final class HintsTableViewController: UITableViewController {
    
    private struct Constants {
        static let cellID = "cellID"
    }
    
    var subject: Subject?
    private var hints = [Hint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    // MARK: - private funcs
    
    private func fetchData() {
        guard let subject = subject else {
            return
        }
        guard let hintsResults = Services.realmDatabase.getHints(from: subject) else {
            hints = []
            return
        }
        hints = hintsResults.compactMap({return $0})
        tableView.reloadData()
    }
    
    private func deleteRow(with hint: Hint) {
        guard Services.realmDatabase.deleteHint(hint) else {
            self.showError(errorDescription: "Не удалось удалить заметку")
            return
        }
        fetchData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = subject?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHint))
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
    }
    
    // MARK: - objc funcs
    
    @objc private func addHint() {
        guard let subject = subject else { return }
        let addHintViewController = AddHintViewController()
        addHintViewController.subject = subject
        present(addHintViewController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hints.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        cell.textLabel?.text = hints[indexPath.row].name
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hintViewController = HintViewController()
        hintViewController.hint = hints[indexPath.row]
        present(hintViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteRow(with: hints[indexPath.row])
        }
    }

}
