//
//  Market.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import Foundation

struct Market : Codable {
    var mic : String
    var tapeId : String
    var venueName : String
    var tapeA : Int
    var tapeB : Int
    var tapeC : Int
    var marketPercent : Float
    init?(json : [String : Any]) {
        guard let mic = json["mic"] as? String,
            let tapeId = json["tapeID"] as? String,
            let venueName = json["venueName"] as? String,
            let tapeA = json["tapeA"] as? Int,
            let tapeB = json["tapeB"] as? Int,
            let tapeC = json["tapeC"] as? Int,
            let marketPercent = json["marketPercent"] as? Float else {
                return nil
        }
        self.mic = mic
        self.tapeId = tapeId
        self.venueName = venueName
        self.tapeA = tapeA
        self.tapeB = tapeB
        self.tapeC = tapeC
        self.marketPercent = marketPercent
    }
    static func marketURL() -> String {
        return "https://api.iextrading.com/1.0/market"
    }
    static func allMarket(completionHandler: @escaping ([Market]?, Error?) -> Void) {
        let endpoint = Market.marketURL()
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
                let todos = try decoder.decode([Market].self, from: responseData)
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
