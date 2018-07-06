//
//  WelcomeHandlers.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension WelcomeVC {
    @objc public func handleStartButton(){
        let mainVC = UINavigationController(rootViewController: MainVC())
        present(mainVC, animated: true, completion: nil)
    }
}
