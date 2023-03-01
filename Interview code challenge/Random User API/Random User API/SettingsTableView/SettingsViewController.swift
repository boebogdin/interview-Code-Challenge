//
//  SettingsViewController.swift
//  Random User API
//
//  Created by Boe Bogdin on 2/27/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsTableViewCellDelegate {
    
    
    
    
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    @IBOutlet weak var howMany: UITextField!
    
    var usersToPass: [User] = []
    
    var settings = API.settings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        print(settings)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingsTableViewCell
        
        configure(cell: cell, forRowAt: indexPath)
        
        return cell
    }
    
    func configure(cell: SettingsTableViewCell, forRowAt indexPath: IndexPath) {
        let settingsArray = Array(settings.keys)
        cell.delegate = self
        cell.settingLabel.text = settingsArray[indexPath.row]
    }
    
    

    @IBSegueAction func prepareForSegue(_ coder: NSCoder) -> ShowUsersViewController? {
        let controller = ShowUsersViewController(coder: coder, users: self.usersToPass)
        
        return controller
    }
    
    
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        
        Task {
            let number = String(howMany.text ?? "1")
            
            let users = try await API.makeCall(number: number)?.results
            if let users = users {
                self.usersToPass = users
    
                performSegue(withIdentifier: "segueToShowUsers", sender: nil)
            }
        }
        
        
        
        
    }
    func updateBool(forKey key: String) {
        API.settings[key]?.toggle()
    }
    
    
    
}


