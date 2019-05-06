//
//  Symbols.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import Foundation

struct Symbol : Codable {
    var symbol : String
    var name : String
    init?(json : [String : Any]) {
        guard let symbol = json["symbol"] as? String,
            let name = json["name"] as? String else {
                return nil
        }
        self.symbol = symbol
        self.name = name
    }
    static func symbolURL() -> String {
        return "https://api.iextrading.com/1.0/ref-data/symbols"
    }
    static func allSymbols(completionHandler: @escaping ([Symbol]?, Error?) -> Void) {
        let endpoint = Symbol.symbolURL()
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let todos = try decoder.decode([Symbol].self, from: responseData)
                completionHandler(todos, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
