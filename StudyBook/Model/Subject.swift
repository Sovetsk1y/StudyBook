//
//  Subject.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 16/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//
import RealmSwift

class Subject: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var name = ""
}
