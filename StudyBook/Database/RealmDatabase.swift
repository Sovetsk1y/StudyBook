//
//  RealmDatabase.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 17/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import RealmSwift

final class RealmDatabase {
    
    var realm: Realm? = {
        do {
            let realm = try Realm()
            return realm
        } catch {
            return nil
        }
    }()
    
    //MARK: - private funcs
    
    private func incrementSubjectID() -> Int {
        guard let realm = realm else { return -1 }
        return (realm.objects(Subject.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    //MARK: - public funcs
    
    func getSubjects() -> Results<Subject>? {
        guard let realm = realm else { return nil }
        let subjects = realm.objects(Subject.self)
        return subjects
    }
    
    func saveSubject(_ subject: Subject) -> Bool {
        guard let realm = realm else {
            return false
        }
        subject.id = incrementSubjectID()
        do {
            try realm.write {
                realm.add(subject)
            }
        } catch {
            return false
        }
        return true
    }
    
    func saveHint(_ hint: Hint) -> Bool {
        guard let realm = realm else { return false }
        do {
            try realm.write {
                realm.add(hint)
            }
        } catch {
            return false
        }
        return true
    }
    
    func getHints(from subject: Subject) -> Results<Hint>? {
        guard let realm = realm else { return nil }
        let hints = realm.objects(Hint.self).filter("subject.id = \(subject.id)")
        return hints
    }
    
    func deleteSubject(_ subject: Subject) -> Bool {
        guard let realm = realm else { return false }
        do {
            let hints = realm.objects(Hint.self).filter("subject.id = \(subject.id)")
            try realm.write {
                realm.delete(hints)
                realm.delete(subject)
            }
        } catch {
            return false
        }
        return true
    }
    
    func deleteHint(_ hint: Hint) -> Bool {
        guard let realm = realm else { return false }
        do {
            try realm.write {
                realm.delete(hint)
            }
        } catch {
            return false
        }
        return true
    }
    
}
