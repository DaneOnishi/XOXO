//
//  ArchiveRepository.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class ArchiveRepository {
    static let shared = ArchiveRepository()
    
    let archiveListKey = "archiveListKey"
    
    lazy var personRepository = {
        PersonRepository.shared
    }()
    
    lazy var gossipRepository = {
        GossipRepository.shared
    }()
    
    private init() {}
    
    func createArchive(title: String?, archiveDate: Date, text: String, gossipID: String) -> Archive {
        let id = String.randomString(length: 20)
        let archive = Archive(id: id, archiveDate: archiveDate, text: text, gossipID: gossipID)
        return archive
    }
    
    func saveArchive(archive: Archive) {
        let data = try!
            JSONEncoder().encode(archive)
        UserDefaults.standard.set(data, forKey: archive.id)
        
        var list = getArchiveListIDs()
        if !list.contains(archive.id) {
            list.append(archive.id)
            saveArchiveListIDs(ids: list)
        }
    }
    
    func deleteArchive(archive: Archive) {
        UserDefaults.standard.removeObject(forKey: archive.id)
        
        var list = getArchiveListIDs()
        list.removeAll { id in
            id == archive.id
        }
        saveArchiveListIDs(ids: list)
        
        if let gossip = gossipRepository.fetchGossip(id: archive.gossipID) {
            gossip.archivesIDs.removeAll { id in
                id == archive.id
            }
            
            gossipRepository.saveGossip(gossip: gossip)
        }
        
        if let ownerId = archive.originPersonID,
           let owner = personRepository.fetchPerson(id: ownerId) {
            owner.archivesAuthoredID.removeAll { id in
                id == archive.id
            }
            personRepository.savePerson(person: owner)
        }
        
        let peopleMentioned = personRepository.mentionedPeople(archive: archive)
        
        for person in peopleMentioned {
            person.archivesMentionedID.removeAll { id in
                id == archive.id
            }
            personRepository.savePerson(person: person)
        }
        
        
    }
    
    func fetchArchives() -> [Archive]{
        // função para pegar todos os archives
        let list = getArchiveListIDs()
        
        var archiveList: [Archive] = []
        
        for id in list {
            let archive = fetchArchive(id: id)
            if let archive = archive {
                archiveList.append(archive)
            }
        }
        return archiveList
        
      //  getArchiveListIDs().compactMap { fetchArchive(id: $0) }
    }
    
    func fetchArchives(gossipID: String) -> [Archive]{
        let list = fetchArchives()
        let archivesList = list.filter { archive in
            archive.gossipID == gossipID
        }
        return archivesList
    }
    
    func fetchArchive(id: String) -> Archive? {
        // função para pegar um archive dado o id
        guard let data = UserDefaults.standard.object(forKey: id) as? Data else { return nil }
        return try?
            JSONDecoder().decode(Archive.self, from: data)
    }
    
    func fetchPersonArchives(originPersonID: String) -> [Archive] {
        let list = fetchArchives()
        let archivesList = list.filter { archive in
            archive.originPersonID == originPersonID
        }
        return archivesList
    }
    
    func fetchMentionedPersonArchives(mentionedPerson: String) -> [Archive] {
//        UserDefaults.standard.object(forKey: mentionedPerson) as? [Archive] ?? []
        let list = fetchArchives()
        let archivesList = list.filter { archive in
            archive.mentionedPeople.contains(mentionedPerson)
        }
        return archivesList
    }
    
    
    
    private func getArchiveListIDs() -> [String] {
        UserDefaults.standard.object(forKey: archiveListKey) as? [String] ?? []
    }
    
    private func saveArchiveListIDs(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: archiveListKey)
    }
    
}
