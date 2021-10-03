//
//  ArchiveCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class ArchiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileButton: UIButton!
    var archive: Archive?
      
    func updateUI(archive: Archive) {
        self.archive = archive
    }
}
