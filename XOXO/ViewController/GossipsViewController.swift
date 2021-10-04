//
//  ArchivesViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class GossipsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var gossipCollectionView: UICollectionView!
    @IBOutlet weak var collectionBackgroundView: UIView!
    @IBOutlet weak var commandBarBackground: UIView!
    @IBOutlet weak var addArchiveButton: UIButton!
    @IBOutlet weak var addGossipButton: UIButton!
    @IBOutlet weak var hightlightsButton: UIButton!
    
    
    var gossips: [Gossip] = []
    var cellScale : CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionBackgroundView.layer.cornerRadius = 40
        
        commandBarBackground.layer.cornerRadius = commandBarBackground.frame.height/2
        
        gossipCollectionView.delegate = self
        gossipCollectionView.dataSource = self
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.gossipCollectionView.addGestureRecognizer(lpgr)
    }
    
    @IBAction func addArchiveButtonOnPress(_ sender: Any) {
    }
    
    @IBAction func addGossipButtonOnPress(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Gossip Girl", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Title"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Summary"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let title = firstTextField.text
            
            let secondTextField = alertController.textFields![1] as UITextField
            let summary = secondTextField.text
            
            guard let title = title else { return }
            
            let gossip = GossipRepository.shared.createGossip(name: title, creationDate: Date(), summary: summary)
            GossipRepository.shared.saveGossip(gossip: gossip)
            
            self.reloadCollection()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func highlightsButtonOnPress(_ sender: Any) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadCollection()
    }
    
    func reloadCollection() {
        gossips = GossipRepository.shared.fetchGossips()
        gossipCollectionView.reloadData()
    }
    
    @objc
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.gossipCollectionView)
        let indexPath = self.gossipCollectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            let gossip = gossips[index.item]
            
            let alertController = UIAlertController(title: "Gossip", message: "", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { alert -> Void in
                GossipRepository.shared.deleteGossip(gossip: gossip)
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
