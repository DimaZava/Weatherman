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

    func add(userData: UserData) {

        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(userData)
            guard let dictionary = try JSONSerialization
                .jsonObject(with: jsonData,
                            options: .allowFragments) as? [String: Any] else {
                                Logger.log("Unable to form dictionary from UserData object"); return
            }

            _ = db.collection("users").addDocument(data: dictionary) { err in
                if let err = err {
                    Logger.log("Error adding document: \(err)")
                } else {
                    //Logger.log("Document added with ID: \(ref!.documentID)")
                }
            }
        } catch {
            Logger.log(error)
        }
    }
}
