//
//  Receta.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/21/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import Foundation
import Firebase

struct Receta {
    
    let key : String
    let name : String
    let image : UIImage?
    let ingredients : [String]
    let description : String
    let coockTime : Int
    var isFavorite : Bool = false
    let addedByUser : String
    let ref : FIRDatabaseReference?
    
    init(name : String, ingredients : [String], description : String, cookTime : Int, addedByUser : String, key : String = ""){
        self.key = key
        self.name = name
        self.image = nil
        self.ingredients = ingredients
        self.description = description
        self.coockTime = cookTime
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        image = snapshotValue["image"] as! UIImage
        ingredients = snapshotValue["ingredients"] as! [String]
        description = snapshotValue["description"] as! String
        coockTime = snapshotValue["coockTime"] as! Int
        isFavorite = snapshotValue["coockTime"] as! Bool
        addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "image": image,
            "ingredients": ingredients,
            "description": description,
            "coockTime": coockTime,
            "isFavorite": isFavorite,
            "addedByUser": addedByUser,
        ]
    }
    
}
