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
    private init() {}
    
    func addPerson(name: String , photo: String) -> Person {
        let id = String.randomString(length: 20)
        let person = Person(name: name, id: id, photo: photo)
        return person
    }
    
    func savePerson(person: Person) {
        UserDefaults.standard.set(person, forKey: person.id)
        
        var list = getPersonListIDs()
        list.append(person.id)
        savePersonListIDs(ids: list)
    }
    
    private func getPersonListIDs() -> [String] {
        UserDefaults.standard.object(forKey: personListKey) as? [String] ?? []
    }
    
    private func savePersonListIDs(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: personListKey)
    }
}
