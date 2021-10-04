//
//  PeopleMentionedCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class PeopleMentionedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var peopleMentionedImageView: UIImageView!
    
    func setupCell(person: Person, selected: Bool) {
        peopleMentionedImageView.layer.cornerRadius = peopleMentionedImageView.frame.height/2
        peopleMentionedImageView.image = person.photoAsImage
        
        if selected {
            peopleMentionedImageView.layer.borderWidth = 5
            peopleMentionedImageView.layer.borderColor = UIColor.white.cgColor
        } else {
            peopleMentionedImageView.layer.borderWidth = 0
        }
    }
}
