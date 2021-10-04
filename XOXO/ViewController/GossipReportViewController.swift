//
//  GossipReportViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class GossipReportViewController: UIViewController {

    @IBOutlet weak var reportText: UITextView!
    var archive: Archive?
    var peopleMentioned: [Person] = []
    @IBOutlet weak var gossipReportCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportText.text = archive?.text
        
        gossipReportCollectionView.dataSource = self
        
        if let archive = archive {
            peopleMentioned = PersonRepository.shared.mentionedPeople(archive: archive)
         
        }
        
    }
}

extension GossipReportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        peopleMentioned.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleMentionedReportCollectionViewCell", for: indexPath) as! PeopleMentionedReportCollectionViewCell
        
//        let gossip = gossips[indexPath.item]
//        cell.updateUI(gossip: gossip)
        let peopleMentioned = peopleMentioned[indexPath.item]
        cell.setupCell(person: peopleMentioned)
        return cell
    }
}
