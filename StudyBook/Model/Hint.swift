//
//  Hint.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//
import RealmSwift

class Hint: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var subject: Subject!
    
}
