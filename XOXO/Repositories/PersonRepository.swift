//
//  PersonRepository.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

class PersonRepository {
    static let shared = PersonRepository()
    
    let personListKey = "personListKey"
    
    lazy var archiveRepository = {
        ArchiveRepository.shared
    }()
    
    lazy var gossipRepository = {
        GossipRepository.shared
    }()
    
    private init() {}
    
    func addPerson(name: String , photo: String) -> Person {
        let id = String.randomString(length: 20)
        let person = Person(name: name, id: id, photo: photo)
        return person
    }
    
    func savePerson(person: Person) {
        let data = try! JSONEncoder().encode(person)
        UserDefaults.standard.set(data, forKey: person.id)
        
        var list = getPersonListIDs()
        
        if !list.contains(person.id) {
            list.append(person.id)
            savePersonListIDs(ids: list)
        }
    }
    
    func deletePerson(person: Person) {
        UserDefaults.standard.removeObject(forKey: person.id)
        
        var list = getPersonListIDs()
        list.removeAll { id in
            id == person.id
        }
        savePersonListIDs(ids: list)
        
        let archivesOwned = archiveRepository.fetchPersonArchives(originPersonID: person.id)
        
        for archive in archivesOwned {
            archive.originPersonID = nil
            archiveRepository.saveArchive(archive: archive)
        }
        
        let archivesMentioned = archiveRepository.fetchMentionedPersonArchives(mentionedPerson: person.id)
        
        for archive in archivesMentioned {
            archive.mentionedPeople.removeAll { id in
                id == person.id
            }
            archiveRepository.saveArchive(archive: archive)
        }
    }
    


    
    func mentionedPeople(gossip: Gossip) -> [Person] {
        let archives = archiveRepository.fetchArchives(gossipID: gossip.id)
        
        var peopleList: [Person] = []
        
        for archive in archives {
            let archivePeopleList = mentionedPeople(archive: archive)
            
            for archivePerson in archivePeopleList {
                if (!peopleList.contains(where: { $0.id == archivePerson.id })) {
                    peopleList.append(archivePerson)
                }
            }
            
        }
        
        return peopleList
    }
    
    func mentionedPeople(archive: Archive) -> [Person] {
        let list = fetchPeople()
        let peopleList = list.filter { person in
            archive.mentionedPeople.contains(person.id)
        }
        return peopleList
    }
    
    func fetchPerson(id: String) -> Person? {
        // pega uma person dado o id da person
        guard let data = UserDefaults.standard.object(forKey: id) as? Data else { return nil }
        return try? JSONDecoder().decode(Person.self, from: data)
    }
    
    func fetchPeople() -> [Person]  {
        let list = getPersonListIDs()
        var personList: [Person] = []
        for id in list {
            let person = fetchPerson(id: id)
            if let person = person {
                personList.append(person)
            }
        }
        return personList
    }
    
    
    
    func addArchiveAsOwned(_ archive: Archive, by person: Person) -> Person {
        archive.originPersonID = person.id
        archiveRepository.saveArchive(archive: archive)
        
        person.archivesAuthoredID.append(archive.id)
        savePerson(person: person)
        
        return person
    }
    
    
    func addArchiveAsMentioning(_ archive: Archive, person: Person) -> Person {
        archive.mentionedPeople.append(person.id)
        archiveRepository.saveArchive(archive: archive)
        
        person.archivesMentionedID.append(archive.id)
        savePerson(person: person)
        
        return person
    }
    
    
    private func getPersonListIDs() -> [String] {
        UserDefaults.standard.object(forKey: personListKey) as? [String] ?? []
    }
    
    private func savePersonListIDs(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: personListKey)
    }
}
