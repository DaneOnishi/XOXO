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
    var gossipDate: Date
    var gossipID: String
    var originPersonID: String?
    var mentionedPeople: [String] = []
    
    internal init(id: String, title: String? = nil, archiveDate: Date, gossipDate: Date, gossipID: String, originPersonID: String? = nil, mentionedPeople: [String] = []) {
        self.id = id
        self.title = title
        self.archiveDate = archiveDate
        self.gossipDate = gossipDate
        self.gossipID = gossipID
        self.originPersonID = originPersonID
        self.mentionedPeople = mentionedPeople
    }
}
