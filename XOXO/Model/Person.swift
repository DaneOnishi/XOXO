//
//  Person.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class Person: Codable {
    let id: String
    var name: String
    var photo: String
    
    internal init(name: String, id: String, photo: String) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
