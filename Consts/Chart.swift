//
//  Chart.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/29/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import Foundation

struct ChartDetails : Codable {
    var minute : String
    var high : Float
    var low : Float
    init?(json : [String : Any]) {
        guard let minute = json["minute"] as? String,
            let high = json["high"] as? Float,
            let low = json["low"] as? Float else {
                return nil
        }
        self.minute = minute
        self.high = high
        self.low = low
    }
    static func chartURL(range : Int, symbol : String) -> String {
        switch range {
        case 0:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/1d"
        case 1:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/1m"
        case 2:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/3m"
        default:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart"
        }
    }
    static func allChart(range : Int, symbol : String, completionHandler: @escaping ([ChartDetails]?, Error?) -> Void) {
        let endpoint = ChartDetails.chartURL(range: range, symbol: symbol)
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
                let todos = try decoder.decode([ChartDetails].self, from: responseData)
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

import Foundation

struct ChartDetailsMore : Codable {
    var date : String
    var high : Float
    var low : Float
    init?(json : [String : Any]) {
        guard let date = json["mic"] as? String,
            let high = json["high"] as? Float,
            let low = json["low"] as? Float else {
                return nil
        }
        self.date = date
        self.high = high
        self.low = low
    }
    static func chartURL(range : Int, symbol : String) -> String {
        switch range {
        case 0:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/"
        case 1:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/1m"
        case 2:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/3m"
        case 3:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/6m"
        case 4:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/ytd"
        case 5:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/1y"
        case 6:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/2y"
        case 7:
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart/5y"
        default:
            print("defualted")
            return "https://api.iextrading.com/1.0/stock/\(symbol)/chart"
        }
    }
    static func allChart(range : Int, symbol : String, completionHandler: @escaping ([ChartDetailsMore]?, Error?) -> Void) {
        let endpoint = ChartDetailsMore.chartURL(range: range, symbol: symbol)
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
                let todos = try decoder.decode([ChartDetailsMore].self, from: responseData)
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
