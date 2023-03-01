//
//  ShowUsersViewController.swift
//  Random User API
//
//  Created by Boe Bogdin on 2/28/23.
//

import UIKit

class ShowUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    

    var users: [User]
    
    init?(coder: NSCoder, users: [User]) {
        self.users = users
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.dataSource = self
        usersTableView.delegate = self

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        
        
        configure(cell: cell, at: indexPath)
        
        return cell
    }
    
    func configure(cell: UserTableViewCell, at indexPath: IndexPath) {
        //cell.layer.borderColor = UIColor.white.cgColor
        
        let user = users[indexPath.row]
        
        let fullName = [user.name.first, user.name.last].joined(separator: " ")
        
        if let city = user.location?.city, let country = user.location?.country {
            let location = [city, country].joined(separator: ", ")
            cell.locationLabel.text! += location
            
        } else {
            cell.locationLabel.text! += "N/A"
        }
        
        Task {
            if let data = try await user.getImage() {
                cell.userImage.image = UIImage(data: data)
            }
        }
        
        cell.nameLabel.text! += fullName
        cell.genderLabel.text! += user.gender ?? "N/A"
        cell.nationalityLabel.text! += user.nat ?? "N/A"
        cell.phoneLabel.text! += user.phone ?? "N/A"
        cell.emailLabel.text! += user.email ?? "N/A"
        
        if let dob = user.dob {
            cell.dobLabel.text! += "\(dob.age)"
        } else {
            cell.dobLabel.text! += "N/A"
        }
         
         
        
    }
    
    
    
}
