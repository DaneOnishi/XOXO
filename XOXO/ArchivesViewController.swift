//
//  ArchivesViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 30/09/21.
//

import UIKit

class ArchivesViewController: UIViewController {
    
    
    
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    @IBOutlet weak var viewBar: UIView!
    var archives = Archive.FetchArchives()
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
        archiveCollectionView.dataSource = self
        
    }
}

extension ArchivesViewController : UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archives.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchivesCell", for: indexPath) as! ArchiveCollectionViewCell
        let archive = archives[indexPath.item]
        cell.archive = archive
        return cell 
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

