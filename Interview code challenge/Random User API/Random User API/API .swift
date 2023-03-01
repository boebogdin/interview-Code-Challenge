//
//  API .swift
//  Random User API
//
//  Created by Boe Bogdin on 2/27/23.
//

import Foundation

struct API {
    static let url = URL(string: "https://randomuser.me/api/")
    
    static var settings: [String: Bool] = [
        "Gender" : true,
        "Location" : true,
        "Email" : true,
        "Phone" : true,
        "Nationality" : true,
        "Age" : true
    ]
    
    static func makeCall(number: String) async throws -> Users? {
        //   guard let text = howMany.text, let _ = Int(text) else { return }
        
        var url = API.url
        
        var components: [String] = ["name, picture"]
        
        for key in settings.keys {
            guard settings[key] ?? true else { continue }
            switch key.lowercased() {
                
            case "age":
                components.append("dob")
            case "nationality":
                components.append("nat")
            default:
                components.append(key.lowercased())
                
            }
            
            
        }
        let componentsToAppend = [URLQueryItem(name: "inc", value: components.joined(separator: ",")), URLQueryItem(name: "results", value: number)]
        
        url = url?.appending(queryItems: componentsToAppend)
        
    
    
        let data = try await URLSession.shared.data(for: URLRequest(url: url!))
        
        let decoder = JSONDecoder()
        
        let user = try decoder.decode(Users.self, from: data.0)
        
        return user
        
    }
    
    
}
