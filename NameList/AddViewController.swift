//
//  AddViewController.swift
//  NameList
//
//  Created by Narmin Baghirova on 18.09.24.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func newStudentAdded(list: [String?])
}

class AddViewController: UIViewController {
    
    var list: [String?] = []
    weak var delegate: AddViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 4
    }
    
    func setUsersList (list: [String?]) {
        self.list = list
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        if !nameTextField.text!.isEmpty {
            if list.first(where: {$0 == nameTextField.text!}) != nil {
                let alert = UIAlertController(title: "Error", message: "Already existing name!", preferredStyle: .alert)
                present(alert, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.dismiss(animated: true)
                }
            } else {
                list.append(nameTextField.text)
                delegate?.newStudentAdded(list: list)
                nameTextField.text = ""
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        print(#function)
    }
}
