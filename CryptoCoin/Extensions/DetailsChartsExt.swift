//
//  DetailsCharts.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

extension DetailsVC: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        if chart == dayChart{
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if dataIndex != nil {
                let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
                //                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
                chartDayInfoLabel.text = String(round((value!)*100)/100)
                }
            }
        }else if chart == monthChart {
            for (seriesIndex, dataIndex) in indexes.enumerated() {
                if dataIndex != nil {
                    let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
                    //                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
                    chartMonthInfoLabel.text = String(round((value!)*100)/100)
                }
            }
        }else{
            for (seriesIndex, dataIndex) in indexes.enumerated() {
                if dataIndex != nil {
                    let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
                    //                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
                    chartWeekInfoLabel.text = String(round((value!)*100)/100)
                }
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
