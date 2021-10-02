//
//  Archieves.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class Archive: Codable {
    var title: String?
    var archiveDate: Date
    var gossipDate: Date
    var originPersonID: String?
    var mentionedPeople: [String] = []
    
    internal init(title: String? = nil, archiveDate: Date, gossipDate: Date, originPersonID: String? = nil, mentionedPeople: [String] = []) {
        self.title = title
        self.archiveDate = archiveDate
        self.gossipDate = gossipDate
        self.originPersonID = originPersonID
        self.mentionedPeople = mentionedPeople
    }
}
