//
//  ArchiveViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

class ArchiveViewController: UIViewController, UIGestureRecognizerDelegate {
    
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
        
        archiveCollectionView.dataSource = self
        archiveCollectionView.delegate = self
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.archiveCollectionView.addGestureRecognizer(lpgr)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollection()
    }
    
    func reloadCollection() {
        archives = ArchiveRepository.shared.fetchArchives(gossipID: gossip?.id ?? "")
        archiveCollectionView.reloadData()
    }
    
    @IBAction func addGossipOnPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TextEditoViewController") as! TextEditoViewController
        vc.gossip = gossip
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.archiveCollectionView)
        let indexPath = self.archiveCollectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            let archive = archives[index.item]
            
            let alertController = UIAlertController(title: "Archive", message: "", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { alert -> Void in
                ArchiveRepository.shared.deleteArchive(archive: archive)
                self.reloadCollection()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            print("Could not find index path")
        }
    }
}



extension ArchiveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        archives.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchivesCell", for: indexPath) as! ArchiveCollectionViewCell
        
//        let gossip = gossips[indexPath.item]
//        cell.updateUI(gossip: gossip)
        let archive = archives[indexPath.item]
        cell.updateUI(archive: archive)
        
        return cell
        
        // codigo pra preparar a celular do archive
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


extension ArchiveViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let archive = archives[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "GossipReportView") as! GossipReportViewController
        vc.archive = archive
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension ArchiveViewController: TextEditorViewControllerDelegate {
    func didCreateArchive() {
        reloadCollection()
    }
    
}
