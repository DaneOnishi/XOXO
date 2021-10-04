//
//  Archieves.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class Archive: Codable {
    var id: String
    var title: String?
    var archiveDate: Date
    var text: String
    var gossipID: String
    var originPersonID: String?
    var mentionedPeople: [String] = []
    
    internal init(id: String, title: String? = nil, archiveDate: Date, text: String, gossipID: String, originPersonID: String? = nil, mentionedPeople: [String] = []) {
        self.id = id
        self.title = title
        self.archiveDate = archiveDate
        self.text = text
        self.gossipID = gossipID
        self.originPersonID = originPersonID
        self.mentionedPeople = mentionedPeople
    }
}
