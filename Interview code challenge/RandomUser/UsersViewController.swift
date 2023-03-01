//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Boe Bogdin on 2/24/23.
//

import UIKit

protocol UpdateUsersDelegate {
    func updateUser(userName: String, row: Int)
}

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateUsersDelegate {
    
    func updateUser(userName: String, row: Int) {
        print(row)
        if row == -1 {
            print("Should've Added")
            users.append(User(name: userName))
        } else {
            print("Should've updated")
            users[row].name = userName
        }
        usersTableView.reloadData()
    }
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var selectedUserLabel: UILabel!
    @IBOutlet weak var amountSelectedLabel: UILabel!
    
    @IBOutlet weak var amountSelectedStepper: UIStepper!
    
    var users: [User] = [User(name: "Boe"), User(name: "Damian"), User(name: "Jason")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountSelectedStepper.minimumValue = 1
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    @IBAction func randomUserButtonTapped(_ sender: Any) {
        var randomString = ""
        let randomUsers = users.shuffled()[0..<Int(amountSelectedStepper.value)]
        randomUsers.forEach {
            randomString += $0 == randomUsers.last! ? "\($0.name) " : "\($0.name), "
        }
        selectedUserLabel.text = randomString
    }
    
    @IBAction func amountSelectedStepperChanged(_ sender: Any) {
        let stepperAmount = Int(amountSelectedStepper.value)
        amountSelectedLabel.text = "\(stepperAmount)"
        amountSelectedStepper.maximumValue = Double(users.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        amountSelectedStepper.maximumValue = Double(users.count)

        var content = cell.defaultContentConfiguration()
        content.text = user.name
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            if amountSelectedStepper.value > Double(users.count) {
                amountSelectedStepper.value = Double(users.count)
                amountSelectedLabel.text = "\(Int(amountSelectedStepper.value))"
                amountSelectedStepper.maximumValue = Double(users.count)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBSegueAction func editUserSegue(_ coder: NSCoder) -> AddEditUserViewController? {
        let row = usersTableView.indexPathForSelectedRow?.row
        if let vc = AddEditUserViewController(coder: coder, user: users[row!], row: row!) {
            vc.delegate = self
            return vc
        } else {
            return AddEditUserViewController(coder: coder)
        }
    }
    
    @IBSegueAction func addUserSegue(_ coder: NSCoder) -> AddEditUserViewController? {
        if let vc = AddEditUserViewController(coder: coder) {
            vc.delegate = self
            return vc
        }
        return AddEditUserViewController(coder: coder)
    }
    
}
