//
//  MainHandlers.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

extension MainVC {
    @objc public func uploadBitcoinInfo(){
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                    self.offlineLabel.isHidden = false
                    self.coinCollection.isHidden = true
                }
                else{
                    if data != nil{
                        self.offlineLabel.isHidden = true
                        self.coinCollection.isHidden = false
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
    
    @objc public func updateChart(historyArray: [String]){
        historyChart.removeAllSeries()
        historyRates = historyArray.map{ Double($0)!}
        let series = ChartSeries(historyRates)
        series.area = true
        historyChart.add(series)
        
    }
    
    public func updateInfo(coin: Coin){
        coinPriceLabel.text = "$" + String(round((Double(coin.price))!*100)/100)
        coinMaxPriceLabel.text = "$" + String(round((Double(coin.allTimeHigh.price))!*100)/100)
        chartInfoLabel.text = ""
        navigationController?.navigationBar.topItem?.title = coin.symbol
        coinImage.image = UIImage(named: coin.symbol)
        updateChart(historyArray: coin.history)
    }
    
    @objc public func handleMenu(){
        if (menuShowing){
            UIView.animate(withDuration: 0.3) {
                self.menuHeightAnchor?.isActive = false
                self.menuHeightAnchor = self.menuCollection.heightAnchor.constraint(equalToConstant: 0)
                self.menuHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.menuHeightAnchor?.isActive = false
                self.menuHeightAnchor = self.menuCollection.heightAnchor.constraint(equalToConstant: 80)
                self.menuHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (true) in
            }
        }
        menuShowing = !menuShowing
    }
    
    public func creatMenuArray()->[MenuModel]{
        var array:[MenuModel] = []
        
        let menuItem1 = MenuModel(title: "Detail Info", icon: UIImage(named: "detail"), viewController: DetailsVC())
        let menuItem2 = MenuModel(title: "News", icon: UIImage(named: "news"), viewController: NewsVC())
        let menuItem3 = MenuModel(title: "About", icon: UIImage(named: "about"), viewController: AboutVC() )
        
        array.append(menuItem1)
        array.append(menuItem2)
        array.append(menuItem3)
        return array
    }
    
    public func animateInfoView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.coinPriceLabel.alpha = 1
            self.coinMaxPriceLabel.alpha = 1
            self.coinMaxPriceTitleLabel.isHidden = false
            self.coinPriceTitleLabel.isHidden = false
            self.infoHeightAnchor?.isActive = false
            self.infoHeightAnchor = self.infoView.heightAnchor.constraint(equalToConstant: 260)
            self.infoHeightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in
        }
    }
    
    public func hideMenuIfVisible(){
        self.menuShowing = false
        UIView.animate(withDuration: 0.3) {
            self.menuHeightAnchor?.isActive = false
            self.menuHeightAnchor = self.menuCollection.heightAnchor.constraint(equalToConstant: 0)
            self.menuHeightAnchor?.isActive = true
            self.view.layoutIfNeeded()
            
        }
    }
    
}
