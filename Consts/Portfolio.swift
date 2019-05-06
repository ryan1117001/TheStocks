//
//  Portfolio.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/28/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import Foundation

class Portfolio: NSObject {
    var symbol : String?
    var company : String?
    
    init(dictionary: [String : AnyObject]) {
        self.symbol = dictionary["symbol"] as? String
        self.company = dictionary["company"] as? String
    }
}
