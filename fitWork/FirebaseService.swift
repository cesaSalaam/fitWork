//
//  FirebaseService.swift
//  fitWork
//
//  Created by Lifoma Salaam on 5/3/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService: NSObject {
    
    static let firebase = FirebaseService() //Creating a singleton
    
    static var BASE_URL = "https://fitwork.firebaseio.com" //main reference to firebase database
    
    let mainRef = Firebase(url: BASE_URL)
    
    let userRef = Firebase(url: BASE_URL).childByAppendingPath("Users") //reference for the path of users in the database
    let groupsRef = Firebase(url: BASE_URL).childByAppendingPath("fitGroups") //reference for the path of users in the database

    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
}