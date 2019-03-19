//
//  Storage.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import Firebase

final class Storage {

    static let sharedInstance = Storage()

    private let db = Firestore.firestore()

    private init() {
    }

    func add(userData: [String: Any]) {

        var ref: DocumentReference?
        ref = db.collection("users").addDocument(data: userData) { err in
            if let err = err {
                Logger.log("Error adding document: \(err)")
            } else {
                Logger.log("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
