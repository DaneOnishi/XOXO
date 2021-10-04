//
//  OriginPersonCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class OriginPersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var personImageView: UIImageView!
    
    func setupCell(person: Person, selected: Bool) {
        personImageView.layer.cornerRadius = personImageView.frame.height/2
        personImageView.image = person.photoAsImage
        
        if selected {
            personImageView.layer.borderWidth = 5
            personImageView.layer.borderColor = UIColor.white.cgColor
        } else {
            personImageView.layer.borderWidth = 0
        }
    }
}
