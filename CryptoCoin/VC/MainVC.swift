//
//  MainVC.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import SwiftChart

class MainVC: UIViewController {
    
    let coinCellId = "coinCellId"
    var listOfCoins: [Coin] = []
    let urlString = "https://api.coinranking.com/v1/public/coins"
    var historyRates: [Double] = [0]
    let menuCellId = "menuCellId"
    var menuShowing = false
    var menuHeightAnchor: NSLayoutConstraint?
    var infoHeightAnchor: NSLayoutConstraint?
    var menuList: [MenuModel] = []
    
    
    lazy var menuCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 1, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.isScrollEnabled = true
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    lazy var coinCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 1, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CoinCell.self, forCellWithReuseIdentifier: coinCellId)
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
        label.alpha = 0
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
        label.isHidden = true
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
        label.alpha = 0
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
        label.isHidden = true
        return label
    }()
    
    let coinImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var historyChart: Chart = {
       let chart = Chart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let series = ChartSeries(historyRates)
        chart.gridColor = UIColor.black.withAlphaComponent(0.3)
        chart.axesColor = UIColor.black.withAlphaComponent(0.3)
        chart.xLabels = [1,6,12,18,24]
        chart.xLabelsFormatter = { String(Int(round($1))) + "h" }
        chart.yLabelsFormatter = { String(round(Double($1)*100)/100) +  "$" }
        chart.labelFont = UIFont.systemFont(ofSize: 10)
        series.color = ChartColors.blueColor()
        series.area = true
        chart.add(series)
        return chart
    }()
    
    lazy var chartInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "update"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(uploadBitcoinInfo))
        navigationController?.navigationBar.topItem?.title = "Select Your Coin"
    }
    
    fileprivate func setupView(){
        
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 15).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15).isActive = true
        infoView.topAnchor.constraint(equalTo: menuCollection.bottomAnchor,constant: 8).isActive = true
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoHeightAnchor = infoView.heightAnchor.constraint(equalToConstant: 0)
        infoHeightAnchor?.isActive = true
        
        coinCollection.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        coinCollection.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        coinCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        coinCollection.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20).isActive = true
        coinCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        menuCollection.topAnchor.constraint(equalTo: view.topAnchor,constant: 85).isActive = true
        menuCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuCollection.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        menuHeightAnchor = menuCollection.heightAnchor.constraint(equalToConstant: 0)
        menuHeightAnchor?.isActive = true
        
        historyChart.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        historyChart.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        historyChart.bottomAnchor.constraint(equalTo: infoView.bottomAnchor,constant: -10).isActive = true
        historyChart.heightAnchor.constraint(equalToConstant: 140).isActive = true
        historyChart.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        
        seperatorView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 35).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: historyChart.topAnchor, constant: -15).isActive = true
        seperatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        coinPriceLabel.centerYAnchor.constraint(equalTo: seperatorView.centerYAnchor).isActive = true
        coinPriceLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinPriceLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinPriceTitleLabel.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 25).isActive = true
        coinPriceTitleLabel.leftAnchor.constraint(equalTo: seperatorView.rightAnchor,constant: 10).isActive = true
        coinPriceTitleLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        coinPriceTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinMaxPriceLabel.centerYAnchor.constraint(equalTo: seperatorView.centerYAnchor).isActive = true
        coinMaxPriceLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinMaxPriceLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinMaxPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinMaxPriceTitleLabel.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 25).isActive = true
        coinMaxPriceTitleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        coinMaxPriceTitleLabel.rightAnchor.constraint(equalTo: seperatorView.leftAnchor,constant: -10).isActive = true
        coinMaxPriceTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        chartInfoLabel.bottomAnchor.constraint(equalTo: historyChart.topAnchor).isActive = true
        chartInfoLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor,constant: 10).isActive = true
        chartInfoLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor,constant: -10).isActive = true
        chartInfoLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        coinImage.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 10).isActive = true
        coinImage.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        offlineLabel.centerXAnchor.constraint(equalTo: coinCollection.centerXAnchor).isActive = true
        offlineLabel.centerYAnchor.constraint(equalTo: coinCollection.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: coinCollection.leftAnchor, constant: 10).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: coinCollection.rightAnchor, constant: -10).isActive = true
        offlineLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    fileprivate func addElements() {
        view.addSubview(coinCollection)
        view.addSubview(infoView)
        infoView.addSubview(historyChart)
        infoView.addSubview(seperatorView)
        infoView.addSubview(coinPriceLabel)
        infoView.addSubview(coinMaxPriceLabel)
        infoView.addSubview(coinPriceTitleLabel)
        infoView.addSubview(coinMaxPriceTitleLabel)
        infoView.addSubview(chartInfoLabel)
        infoView.addSubview(coinImage)
        view.addSubview(offlineLabel)
        view.addSubview(menuCollection)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        coinCollection.delegate = self
        coinCollection.dataSource = self
        menuCollection.delegate = self
        menuCollection.dataSource = self
        setupNavBar()
        setupView()
        view.backgroundColor = .white
        DispatchQueue.main.async {
            self.uploadBitcoinInfo()
        }
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(uploadBitcoinInfo), userInfo: nil, repeats: true)
        historyChart.delegate = self
        menuList = creatMenuArray()
        
    }

}
