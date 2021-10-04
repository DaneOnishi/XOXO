//
//  PeopleMentionedReportCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 04/10/21.
//

import UIKit

class PeopleMentionedReportCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reportCollectionViewCell: UIView!
    
    @IBOutlet weak var reportImageCell: UIImageView!
    
    func setupCell(person: Person) {
        reportImageCell.layer.cornerRadius = reportImageCell.frame.height/2
        reportImageCell.image = person.photoAsImage
    }
}
