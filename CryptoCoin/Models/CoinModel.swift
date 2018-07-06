//
//  CoinModel.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

struct MainData: Decodable {
    let data: CoinData
}

struct CoinData: Decodable {
    let stats: Total
    let coins: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let symbol: String
    let name: String
    let circulatingSupply: Int
    let totalSupply: Int
    let iconUrl: String
    let websiteUrl: String
    let price: String
    let marketCap: Int
    let volume: Int
    let change: Double
    let history: [String]
    let allTimeHigh: AllTimeHigh
}

struct Total: Decodable {
    let total: Int
}


struct AllTimeHigh: Decodable {
    let price: String
}
