//
//  ArchiveCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class ArchiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!

    @IBOutlet weak var cellText: UILabel!
    
    
    var archive : Archive! {
          didSet {
              self.updateUI ()
          }
      }
      
      func updateUI() {
        
          if let archive = archive {
            cellImage.image = archive.imageArchive
              cellText.text = archive.title
   
          } else {
              cellImage.image = nil
              cellText.text = nil
          }
      }
  }
