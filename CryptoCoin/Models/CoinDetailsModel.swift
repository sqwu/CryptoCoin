//
//  CoinDetailsModel.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

struct DataHistory: Decodable {
    let data: CoinDetails
}
struct CoinDetails: Decodable {
    let coin: Coin
}


