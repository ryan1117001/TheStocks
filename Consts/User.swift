//
//  User.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/22/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class User: NSObject {
    var username: String?
    var email: String?
    var fullname: String?
    var profileurl: String?
    var funding : String?
    
    init(dictionary: [String: AnyObject]) {
        self.username = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.fullname = dictionary["fullname"] as? String
        self.profileurl = dictionary["profileurl"] as? String
        self.funding = dictionary["funding"] as? String
    }
}
