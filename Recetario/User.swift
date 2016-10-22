//
//  User.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/21/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid : String
    let email : String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}



