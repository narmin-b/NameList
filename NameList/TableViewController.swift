//
//  ViewController.swift
//  NameList
//
//  Created by Narmin Baghirova on 18.09.24.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var nameList: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTable()
    }
    
    
    
    fileprivate func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    fileprivate func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add Name",
            style: .plain,
            target: self,
            action: #selector(showAddController))
    }
    
    @objc fileprivate func showAddController() {
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        controller.delegate = self
        controller.setUsersList(list: nameList)
        controller.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(controller, animated: true)
    }
    
    deinit {}
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.nameLabel.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          nameList.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}

extension TableViewController: AddViewControllerDelegate {
    func newStudentAdded(list: [String?]) {
        nameList = list
        tableView.reloadData()
    }
}
