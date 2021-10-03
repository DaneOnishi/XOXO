//
//  ArchiveViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    var gossip: Gossip?
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var buttonBackground: UIView!
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    
    var archives: [Archive] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundTop.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        backgroundTop.layer.cornerRadius = 40
        
        buttonBackground.layer.cornerRadius = buttonBackground.frame.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        archives = ArchiveRepository.shared.fetchArchives()
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchivesCell", for: indexPath) as! GossipCollectionViewCell
//        let gossip = gossips[indexPath.item]
//        cell.updateUI(gossip: gossip)
//        return cell
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//}
//
//extension GossipsViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let gossip = gossips[indexPath.item]
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "ArchiveViewController") as! ArchiveViewController
//        vc.gossip = gossip
//        
//        self.present(vc, animated: true, completion: nil)
//    }
    

}
