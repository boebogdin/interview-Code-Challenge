//
//  User.swift
//  Random User API
//
//  Created by Boe Bogdin on 2/27/23.
//

import Foundation


struct User : Codable {
    var gender: String?
    var name: Name
    var location: Location?
    var email: String?
    var dob: DOB?
    var phone: String?
    var picture: Picture
    var nat: String?
    
    
    enum CodingKeys: String, CodingKey {
        case gender = "gender"
        case name = "name"
        case location = "location"
        case email = "email"
        case dob = "dob"
        case phone = "phone"
        case picture = "picture"
        case nat = "nat"
    }
    
    func getImage() async throws -> Data? {
       
        
        let request = URLRequest(url: self.picture.large)
        do {
            let data = try await URLSession.shared.data(for: request)
            return data.0
        } catch {
            throw error
        }
        
        
        
        
       
        
    }
    
}

struct Picture: Codable {
    var large: URL
}

struct Name : Codable {
    var title: String
    var first: String
    var last: String
}

struct Location : Codable {
    var city: String
    var country: String
}

struct DOB : Codable {
    var age: Int
}


struct Users : Codable {
    var results: [User]
}
