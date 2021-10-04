//
//  TextEditoViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import UIKit

protocol TextEditorViewControllerDelegate: AnyObject {
    func didCreateArchive()
}

class TextEditoViewController: UIViewController {

    var people: [Person] = []
    @IBOutlet weak var textEditor: UITextView!
    @IBOutlet weak var personImageCollecionView: UICollectionView!
    @IBOutlet weak var peopleMentionedCollectionView: UICollectionView!
    
    var selectedOriginPersonIndex: Int? = nil
    var selectedMentionedPeopleIndexes: [Int] = []
    var gossip: Gossip?

    weak var delegate: TextEditorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        people = PersonRepository.shared.fetchPeople()
        
        personImageCollecionView.dataSource = self
        peopleMentionedCollectionView.dataSource = self
        personImageCollecionView.delegate = self
        peopleMentionedCollectionView.delegate = self
    }
    
    @IBAction func backButtonOnPress(_ sender: Any) {
    }
    
    @IBAction func saveTextOnPress(_ sender: Any) {
        guard let gossip = gossip,
              let gossipID = self.gossip?.id,
              let text = textEditor.text else {
            return
        }

        let archive = ArchiveRepository.shared.createArchive(title: nil, archiveDate: Date(), text: text, gossipID: gossipID)
        // adicionar pessoas no archive
        
        ArchiveRepository.shared.saveArchive(archive: archive)
        _ = GossipRepository.shared.addArchive(archive, to: gossip)
        
        if let selectedOriginPersonIndex = selectedOriginPersonIndex {
            let originPerson = people[selectedOriginPersonIndex]
            _ = PersonRepository.shared.addArchiveAsOwned(archive, by: originPerson)
        }
        
        for index in selectedMentionedPeopleIndexes {
            let mentionedPeople = people[index]
            _ = PersonRepository.shared.addArchiveAsMentioning(archive, person: mentionedPeople)
        }
        
        delegate?.didCreateArchive()
        self.dismiss(animated: true, completion: nil)
    }
}

extension TextEditoViewController : UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == personImageCollecionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OriginPersonCell", for: indexPath) as! OriginPersonCollectionViewCell
            let people = people[indexPath.item]
            let selected = indexPath.item == selectedOriginPersonIndex
            cell.setupCell(person: people, selected: selected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleMentionedCell", for: indexPath) as! PeopleMentionedCollectionViewCell
            let people = people[indexPath.item]
            let selected = selectedMentionedPeopleIndexes.contains(indexPath.item)
            cell.setupCell(person: people, selected: selected)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension TextEditoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        if collectionView == personImageCollecionView {
            if (selectedOriginPersonIndex == index) {
                selectedOriginPersonIndex = nil
            } else {
                selectedOriginPersonIndex = index
            }
        } else {
            if selectedMentionedPeopleIndexes.contains(indexPath.item) {
                selectedMentionedPeopleIndexes.removeAll { collectionIndex in
                    collectionIndex == index
                }
            } else {
                selectedMentionedPeopleIndexes.append(index)
            }
         
        }

        collectionView.reloadData()
        
    }
}

