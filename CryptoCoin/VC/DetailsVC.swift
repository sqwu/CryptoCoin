//
//  DetailsVC.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import SwiftChart

class DetailsVC: UIViewController {

    let coinCellId = "coinCellId"
    var listOfCoins: [Coin] = []
    var historyDay: Coin?
    var historyWeek: Coin?
    var historyMonth: Coin?
    let urlString = "https://api.coinranking.com/v1/public/coins"
    var historyDayPrices: [Double] = [0]
    var historyWeekPrices: [Double] = [0]
    var historyMonthPrices: [Double] = [0]
    let menuCellId = "menuCellId"
    var menuShowing = false
    var menuHeightAnchor: NSLayoutConstraint?
    var menuList: [MenuModel] = []
    
    
    lazy var coinCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 10, bottom: 1, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CoinDetailsCell.self, forCellWithReuseIdentifier: coinCellId)
        view.backgroundColor = UIColor.white
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var infoScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 600
        view.backgroundColor = .white
        return view
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 1
        return view
    }()
    
    lazy var coinPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var coinPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Current Price"
        return label
    }()
    
    lazy var coinMaxPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var coinMaxPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Max Price"
        return label
    }()
    
    lazy var coinVolumeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Volume"
        return label
    }()
    
    lazy var coinVolumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var coinMarketCapTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Market Cap"
        return label
    }()
    
    lazy var coinMarketCapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var coinCirculatingSupplyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Circulating Supply"
        return label
    }()
    
    lazy var coinCirculatingSupplyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var coinTotalSupplyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Total Supply"
        return label
    }()
    
    lazy var coinTotalSupplyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let coinImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var monthChart: Chart = {
        let chart = Chart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let series = ChartSeries(historyDayPrices)
        chart.gridColor = UIColor.black.withAlphaComponent(0.3)
        chart.axesColor = UIColor.black.withAlphaComponent(0.3)
        chart.xLabels = [1,6,12,18,24]
        chart.xLabelsFormatter = { String(Int(round($1))) + "d" }
        chart.yLabelsFormatter = { String(round(Double($1)*100)/100) +  "$" }
        chart.labelFont = UIFont.systemFont(ofSize: 10)
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
        return chart
    }()
    
    lazy var dayChart: Chart = {
        let chart = Chart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let series = ChartSeries(historyDayPrices)
        chart.gridColor = UIColor.black.withAlphaComponent(0.3)
        chart.axesColor = UIColor.black.withAlphaComponent(0.3)
        chart.xLabels = [1,6,12,18,24]
        chart.xLabelsFormatter = { String(Int(round($1))) + "h" }
        chart.yLabelsFormatter = { String(round(Double($1)*100)/100) +  "$" }
        chart.labelFont = UIFont.systemFont(ofSize: 10)
        series.color = ChartColors.greenColor()
        series.area = true
        chart.add(series)
        return chart
    }()
    
    lazy var weekChart: Chart = {
        let chart = Chart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let series = ChartSeries(historyDayPrices)
        chart.gridColor = UIColor.black.withAlphaComponent(0.3)
        chart.axesColor = UIColor.black.withAlphaComponent(0.3)
        chart.xLabels = [2,4,7]
        chart.xLabelsFormatter = { String(Int(round($1))) + "d" }
        chart.yLabelsFormatter = { String(round(Double($1)*100)/100) +  "$" }
        chart.labelFont = UIFont.systemFont(ofSize: 10)
        series.color = ChartColors.blueColor()
        series.area = true
        chart.add(series)
        return chart
    }()
    
    lazy var chartMonthInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var chartMonthTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Month"
        return label
    }()
    
    lazy var chartWeekInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var chartWeekTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Week"
        return label
    }()
    
    lazy var chartDayInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var chartDayTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Day"
        return label
    }()
    
    lazy var offlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "Upps..Please check your connection and press refresh button"
        label.isHidden = true
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "update"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(uploadBitcoinInfo))
        navigationController?.navigationBar.topItem?.title = "Details"
    }
    
    fileprivate func setupView(){
        
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 15).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15).isActive = true
        infoView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90).isActive = true
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: coinCollection.topAnchor, constant: -20).isActive = true
        
        infoScrollView.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 1).isActive = true
        infoScrollView.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -1).isActive = true
        infoScrollView.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 1).isActive = true
        infoScrollView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        infoScrollView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
        infoScrollView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 1).isActive = true
        
        coinCollection.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        coinCollection.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        coinCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        coinCollection.heightAnchor.constraint(equalToConstant: 100).isActive = true
        coinCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dayChart.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        dayChart.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        dayChart.topAnchor.constraint(equalTo: coinCirculatingSupplyLabel.bottomAnchor,constant: 40).isActive = true
        dayChart.heightAnchor.constraint(equalToConstant: 90).isActive = true
        dayChart.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        
        weekChart.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        weekChart.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        weekChart.topAnchor.constraint(equalTo: dayChart.bottomAnchor,constant: 20).isActive = true
        weekChart.heightAnchor.constraint(equalToConstant: 90).isActive = true
        weekChart.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        
        monthChart.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        monthChart.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        monthChart.topAnchor.constraint(equalTo: weekChart.bottomAnchor,constant: 20).isActive = true
        monthChart.heightAnchor.constraint(equalToConstant: 90).isActive = true
        monthChart.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        
        seperatorView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: infoScrollView.topAnchor, constant: 35).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: dayChart.topAnchor, constant: -30).isActive = true
        seperatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        coinPriceLabel.topAnchor.constraint(equalTo: coinPriceTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinPriceLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinPriceLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinPriceTitleLabel.topAnchor.constraint(equalTo: infoScrollView.topAnchor,constant: 25).isActive = true
        coinPriceTitleLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinPriceTitleLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinPriceTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinMarketCapLabel.topAnchor.constraint(equalTo: coinMarketCapTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinMarketCapLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinMarketCapLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinMarketCapLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinMarketCapTitleLabel.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor,constant: 10).isActive = true
        coinMarketCapTitleLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinMarketCapTitleLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinMarketCapTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinTotalSupplyLabel.topAnchor.constraint(equalTo: coinTotalSupplyTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinTotalSupplyLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinTotalSupplyLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinTotalSupplyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinTotalSupplyTitleLabel.topAnchor.constraint(equalTo: coinMarketCapLabel.bottomAnchor,constant: 10).isActive = true
        coinTotalSupplyTitleLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinTotalSupplyTitleLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinTotalSupplyTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinMaxPriceLabel.topAnchor.constraint(equalTo: coinMaxPriceTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinMaxPriceLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinMaxPriceLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinMaxPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinMaxPriceTitleLabel.topAnchor.constraint(equalTo: infoScrollView.topAnchor,constant: 25).isActive = true
        coinMaxPriceTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinMaxPriceTitleLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinMaxPriceTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinVolumeLabel.topAnchor.constraint(equalTo: coinVolumeTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinVolumeLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinVolumeLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinVolumeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinVolumeTitleLabel.topAnchor.constraint(equalTo: coinMaxPriceLabel.bottomAnchor,constant: 10).isActive = true
        coinVolumeTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinVolumeTitleLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinVolumeTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinCirculatingSupplyLabel.topAnchor.constraint(equalTo: coinCirculatingSupplyTitleLabel.bottomAnchor,constant: 10).isActive = true
        coinCirculatingSupplyLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinCirculatingSupplyLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinCirculatingSupplyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinCirculatingSupplyTitleLabel.topAnchor.constraint(equalTo: coinVolumeLabel.bottomAnchor,constant: 10).isActive = true
        coinCirculatingSupplyTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinCirculatingSupplyTitleLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinCirculatingSupplyTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        chartMonthInfoLabel.bottomAnchor.constraint(equalTo: monthChart.topAnchor).isActive = true
        chartMonthInfoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        chartMonthInfoLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartMonthInfoLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        chartMonthTitleLabel.bottomAnchor.constraint(equalTo: monthChart.topAnchor).isActive = true
        chartMonthTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        chartMonthTitleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartMonthTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        chartWeekInfoLabel.bottomAnchor.constraint(equalTo: weekChart.topAnchor).isActive = true
        chartWeekInfoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        chartWeekInfoLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartWeekInfoLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        chartWeekTitleLabel.bottomAnchor.constraint(equalTo: weekChart.topAnchor).isActive = true
        chartWeekTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        chartWeekTitleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartWeekTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        chartDayInfoLabel.bottomAnchor.constraint(equalTo: dayChart.topAnchor).isActive = true
        chartDayInfoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        chartDayInfoLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartDayInfoLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        chartDayTitleLabel.bottomAnchor.constraint(equalTo: dayChart.topAnchor).isActive = true
        chartDayTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        chartDayTitleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        chartDayTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        coinImage.topAnchor.constraint(equalTo: infoScrollView.topAnchor,constant: 10).isActive = true
        coinImage.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        offlineLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        offlineLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        offlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func addElements() {
        view.addSubview(coinCollection)
        view.addSubview(infoView)
        infoView.addSubview(infoScrollView)
        infoView.addSubview(offlineLabel)
        infoScrollView.addSubview(monthChart)
        infoScrollView.addSubview(dayChart)
        infoScrollView.addSubview(weekChart)
        infoScrollView.addSubview(chartWeekInfoLabel)
        infoScrollView.addSubview(chartDayInfoLabel)
        infoScrollView.addSubview(seperatorView)
        infoScrollView.addSubview(coinPriceLabel)
        infoScrollView.addSubview(coinMaxPriceLabel)
        infoScrollView.addSubview(coinPriceTitleLabel)
        infoScrollView.addSubview(coinMaxPriceTitleLabel)
        infoScrollView.addSubview(chartMonthInfoLabel)
        infoScrollView.addSubview(coinImage)
        infoScrollView.addSubview(chartDayTitleLabel)
        infoScrollView.addSubview(chartMonthTitleLabel)
        infoScrollView.addSubview(chartWeekTitleLabel)
        infoScrollView.addSubview(coinVolumeTitleLabel)
        infoScrollView.addSubview(coinVolumeLabel)
        infoScrollView.addSubview(coinMarketCapTitleLabel)
        infoScrollView.addSubview(coinMarketCapLabel)
        infoScrollView.addSubview(coinTotalSupplyLabel)
        infoScrollView.addSubview(coinTotalSupplyTitleLabel)
        infoScrollView.addSubview(coinCirculatingSupplyTitleLabel)
        infoScrollView.addSubview(coinCirculatingSupplyLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        coinCollection.delegate = self
        coinCollection.dataSource = self
        setupNavBar()
        setupView()
        view.backgroundColor = .white
        uploadBitcoinInfo()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(uploadBitcoinInfo), userInfo: nil, repeats: true)
        monthChart.delegate = self
        dayChart.delegate = self
        weekChart.delegate = self
        
    }

}
