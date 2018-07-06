//
//  MainChartExt.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

extension MainVC: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if dataIndex != nil {
                let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
//                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
                chartInfoLabel.text = String(round((value!)*100)/100)
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        return(print("didFinishTouchingChart"))
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        return(print("didEndTouchingChart"))
    }
    
    
}
