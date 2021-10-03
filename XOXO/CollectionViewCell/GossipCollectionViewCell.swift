//
//  ArchiveCollectionViewCell.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class GossipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!

    @IBOutlet weak var cellText: UILabel!
    
    var gossip: Gossip?
      
    func updateUI(gossip: Gossip) {
        self.gossip = gossip
        cellText.text = gossip.name
    }
}
