//
//  AddEditUserViewController.swift
//  RandomUser
//
//  Created by Boe Bogdin on 2/24/23.
//

import UIKit

class AddEditUserViewController: UIViewController {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    
    var user: User? = nil
    var isEditingUser = false
    var row: Int = 0
    
    var delegate: UpdateUsersDelegate?
    
    init?(coder: NSCoder, user: User?, row: Int) {
        self.user = user
        self.row = row
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editOrAdd()
    }
    
    func editOrAdd() {
        if let user {
            isEditingUser = true
            userNameTextField.text = user.name
            mainTitleLabel.text = "Edit User"
        } else {
            isEditingUser = false
            userNameTextField.placeholder = "User name"
            mainTitleLabel.text = "Add User"
        }
    }
    
    @IBAction func addSaveButtonTapped(_ sender: Any) {
        if isEditingUser == true {
            delegate?.updateUser(userName: userNameTextField.text ?? "" , row: row)
        } else {
            delegate?.updateUser(userName: userNameTextField.text ?? "" , row: -1)
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
