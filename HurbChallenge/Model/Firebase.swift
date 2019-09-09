//
//  Firebase.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.


import Firebase


class FBRef {
    static var db:Firestore!
    
    static var users = FBRef.db.collection("users")
}
