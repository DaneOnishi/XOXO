//
//  GossipRepository.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class GossipRepository {
    static let shared = GossipRepository()
    
    lazy var personRepository = {
        PersonRepository.shared
    }()
    
    lazy var archiveRepository = {
        ArchiveRepository.shared
    }()

    let gossipListKey = "gossipListKey"
    
    private init() {}
    
    func createGossip(name: String, creationDate: Date, summary: String?) -> Gossip {
        let id = String.randomString(length: 20)
        let gossip = Gossip(id: id, name: name, creationDate: creationDate, archivesIDs: [], summary: summary)
        return gossip
    }
    
    func saveGossip(gossip: Gossip) {
        let data = try! JSONEncoder().encode(gossip)
        UserDefaults.standard.set(data, forKey: gossip.id)
        
        
        var list = getGossipListIDs()
        if !list.contains(gossip.id) {
            list.append(gossip.id)
            saveGossipListIDs(ids: list)
        }
        
    }
    
    func addArchive(_ archive: Archive, to gossip: Gossip) -> Gossip {
        archive.gossipID = gossip.id
        archiveRepository.saveArchive(archive: archive)
        
        gossip.archivesIDs.append(archive.id)
        saveGossip(gossip: gossip)
        
        return gossip
    }
    
    
    func deleteGossip(gossip: Gossip) {
        let gossipArchives = archiveRepository.fetchArchives(gossipID: gossip.id)
        for archive in gossipArchives {
            archiveRepository.deleteArchive(archive: archive)
        }
        
        UserDefaults.standard.removeObject(forKey: gossip.id)
        
        var list = getGossipListIDs()
        list.removeAll { id in
            id == gossip.id
        }
        saveGossipListIDs(ids: list)
    }
    
    func fetchGossips() -> [Gossip] {
        //pega todas as gossips
        let list = getGossipListIDs()
        
        var gossipList: [Gossip] = []
        
        for id in list {
            let gossip = fetchGossip(id:id)
            if let gossip = gossip {
                gossipList.append(gossip)
            }
        }
        
        return gossipList
    }
    
    
    func fetchGossip(id: String) -> Gossip? {
        // pega uma gossip dado o ID da gossip
        guard let data = UserDefaults.standard.object(forKey: id) as? Data else { return nil }
        return try?
            JSONDecoder().decode(Gossip.self, from: data)
    }
    
    private func getGossipListIDs() -> [String] {
        UserDefaults.standard.object(forKey: gossipListKey) as? [String] ?? []
    }
    
    private func saveGossipListIDs(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: gossipListKey)
    }
    
}
