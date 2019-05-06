//
//  StockData.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/23/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import Foundation

struct Company : Decodable {
    let companyName : String?
    let exchange : String?
    let industry : String?
    let CEO : String?
    let description : String?
}

struct Quote : Decodable {
    let open : Float?
    let close : Float?
    let high : Float?
    let low : Float?
    let latestPrice : Float?
    let latestTime: String?
    let latestVolume: Int?
    let change : Float?
    let changePercent : Float?
    let iexMarketPercent : Float?
    let marketCap : Int?
    let peRatio : Float?
    let week52High : Float?
    let week52Low : Float?
    let ytdChange : Float?
}
