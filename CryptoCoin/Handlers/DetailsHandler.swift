//
//  DetailsHandler.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

extension DetailsVC {
    @objc public func uploadBitcoinInfo(){
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                    self.offlineLabel.isHidden = false
                    self.infoScrollView.isHidden = true
                }
                else{
                    if data != nil{
                        self.offlineLabel.isHidden = true
                        self.infoScrollView.isHidden = false
                        self.listOfCoins.removeAll()
                        do{
                            let json = try JSONDecoder().decode(MainData.self, from: data!)
                            self.listOfCoins = json.data.coins
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.coinCollection.reloadData()
            }
        }
        task.resume()
    }
    
    @objc public func handleBack(){
        let vc = UINavigationController(rootViewController: MainVC())
        present(vc, animated: true, completion: nil)
    }
    
    public func updateInfo(coin: Coin){
        coinPriceLabel.text = "$" + String(round((Double(coin.price))!*100)/100)
        coinMaxPriceLabel.text = "$" + String(round((Double(coin.allTimeHigh.price))!*100)/100)
        coinVolumeLabel.text = String(coin.volume)
        coinMarketCapLabel.text = String(coin.marketCap)
        coinCirculatingSupplyLabel.text = String(coin.circulatingSupply)
        coinTotalSupplyLabel.text = String(coin.totalSupply)
        chartMonthInfoLabel.text = ""
        chartWeekInfoLabel.text = ""
        chartDayInfoLabel.text = ""
        navigationController?.navigationBar.topItem?.title = coin.symbol + " Details"
        coinImage.image = UIImage(named: coin.symbol)
        updateMonthChart(historyArray: coin.history)
    }
    
    @objc public func updateMonthChart(historyArray: [String]){
        monthChart.removeAllSeries()
        historyMonthPrices = historyArray.map{ Double($0)!}
        let series = ChartSeries(historyMonthPrices)
        series.area = true
        monthChart.add(series)
    }
    
    public func updateWeekChart(historyArray: [String]){
        weekChart.removeAllSeries()
        historyWeekPrices = historyArray.map{ Double($0)!}
        let series = ChartSeries(historyWeekPrices)
        series.area = true
        weekChart.add(series)
    }
    
    public func updateDayChart(historyArray: [String]){
        dayChart.removeAllSeries()
        historyDayPrices = historyArray.map{Double($0)!}
        let series = ChartSeries(historyDayPrices)
        series.area = true
        dayChart.add(series)
    }
    
    public func uploadMonthHistory(coin: Coin){
        let weekUrl = "https://api.coinranking.com/v1/public/coin/" + String(coin.id) + "?base=USD&timePeriod=30d"
        guard let url = URL(string: weekUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        self.historyMonthPrices.removeAll()
                        do{
                            let json = try JSONDecoder().decode(DataHistory.self, from: data!)
                            self.historyMonth = json.data.coin
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.updateMonthChart(historyArray: (self.historyMonth?.history)!)
            }
        }
        task.resume()
    }
    
    public func uploadWeekHistory(coin: Coin){
        let weekUrl = "https://api.coinranking.com/v1/public/coin/" + String(coin.id) + "?base=USD&timePeriod=7d"
        guard let url = URL(string: weekUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        self.historyWeekPrices.removeAll()
                        do{
                            let json = try JSONDecoder().decode(DataHistory.self, from: data!)
                            self.historyWeek = json.data.coin
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.updateWeekChart(historyArray: (self.historyWeek?.history)!)
            }
        }
        task.resume()
    }
    
    public func uploadDayHistory(coin: Coin){
        let weekUrl = "https://api.coinranking.com/v1/public/coin/" + String(coin.id) + "?base=USD&timePeriod=7d"
        guard let url = URL(string: weekUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        self.historyDayPrices.removeAll()
                        do{
                            let json = try JSONDecoder().decode(DataHistory.self, from: data!)
                            self.historyDay = json.data.coin
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.updateDayChart(historyArray: (self.historyDay?.history)!)
            }
        }
        task.resume()
    }
    
}
