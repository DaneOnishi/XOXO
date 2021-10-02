//
//  Gossip.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class Gossip: Codable {
    let id: String
    var name: String
    var creationDate: Date
    var archivesIDs: [String]
    var summary: String?
    
    internal init(id: String, name: String, creationDate: Date, archivesIDs: [String], summary: String? = nil) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.archivesIDs = archivesIDs
        self.summary = summary
    }
}
