//
//  GossipRepository.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class GossipRepository {
    static let shared = GossipRepository()
    let gossipListKey = "gossipListKey"
    private init() {}
    
    func createGossip(name: String, creationDate: Date, summary: String?) -> Gossip {
        let id = String.randomString(length: 20)
        let gossip = Gossip(id: id, name: name, creationDate: creationDate, archivesIDs: [], summary: summary)
        return gossip
    }
    
    func saveGossip(gossip: Gossip) {
        UserDefaults.standard.set(gossip, forKey: gossip.id)
        
        var list = getGossipListIDs()
        list.append(gossip.id)
        saveGossipListIDs(ids: list)
    }
    
    func addArchive(_ archive: Archive, to gossip: Gossip) -> Gossip {
        // Adiciona archive na gossip
        // Salva a gossip
        // Retorna a gossip modificada
        return gossip
    }
    
    func removeGossip(gossip: Gossip) {
        // Pega os arquivos dela
        // Deleta cada arquivo avisando a gossip
        // Deleta a gossip
    }
    
    private func getGossipListIDs() -> [String] {
        UserDefaults.standard.object(forKey: gossipListKey) as? [String] ?? []
    }
    
    private func saveGossipListIDs(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: gossipListKey)
    }
    
}
