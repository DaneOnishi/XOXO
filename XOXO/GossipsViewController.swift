//
//  ArchivesViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class GossipsViewController: UIViewController {
    
    @IBOutlet weak var gossipCollectionView: UICollectionView!
    @IBOutlet weak var viewBar: UIView!
    var gossips: [Gossip] = []
    var cellScale : CGFloat = 0.6
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //let screenSize = UIScreen.main.bounds.size
        //   let cellWidth = floor(screenSize.width * cellScale )
        //  let cellHeight = floor(screenSize.height * cellScale)
        //  let instX = ( view.bounds.width - cellWidth ) / 2.0
        //  let instY = ( view.bounds.height - cellHeight ) / 2.0
        //let layout = archiveCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        //   layout.itemSize = CGSize(width: cellWidth, height: cellHeight )
        //    archiveCollectionView.contentInset = UIEdgeInsets(top: instY , left: instX , bottom: instY, right: instX )
        gossipCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gossips = GossipRepository.shared.fetchGossips()
    }
}

extension GossipsViewController : UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gossips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GossipsCell", for: indexPath) as! GossipCollectionViewCell
        let gossip = gossips[indexPath.item]
        cell.gossip = gossip
        return cell 
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension GossipsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
