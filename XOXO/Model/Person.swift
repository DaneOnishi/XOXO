//
//  Person.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation
import UIKit

class Person: Codable {
    let id: String
    var name: String
    var photo: String
    var archivesMentionedID: [String] = []
    var archivesAuthoredID: [String] = []
    
    var photoAsImage: UIImage {
        photo.convertBase64StringToImage()
    }
    
    internal init(name: String, id: String, photo: String) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
