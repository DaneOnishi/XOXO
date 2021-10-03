//
//  ArchivesViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class GossipsViewController: UIViewController {
    
    @IBOutlet weak var gossipCollectionView: UICollectionView!
    @IBOutlet weak var collectionBackgroundView: UIView!
    @IBOutlet weak var commandBarBackground: UIView!
    
    var gossips: [Gossip] = []
    var cellScale : CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionBackgroundView.layer.cornerRadius = 40
        
        commandBarBackground.layer.cornerRadius = commandBarBackground.frame.height/2
        
        gossipCollectionView.delegate = self
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
        cell.updateUI(gossip: gossip)
        return cell 
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension GossipsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gossip = gossips[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ArchiveViewController") as! ArchiveViewController
        vc.gossip = gossip
        
        self.present(vc, animated: true, completion: nil)
    }
}
