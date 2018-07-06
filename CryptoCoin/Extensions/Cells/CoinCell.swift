//
//  CoinCell.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CoinCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    let coinName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let coinPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
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
    
    let coinSymbol: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let coinStatusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let coinRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    func setupView(){
        addSubview(coinName)
        addSubview(coinPrice)
        addSubview(coinImage)
        addSubview(coinSymbol)
        addSubview(coinStatusImage)
        addSubview(coinRate)
        
        coinName.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        coinName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        coinName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        coinName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinPrice.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        coinPrice.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        coinPrice.widthAnchor.constraint(equalToConstant: 80).isActive = true
        coinPrice.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coinStatusImage.centerYAnchor.constraint(equalTo: coinPrice.centerYAnchor).isActive = true
        coinStatusImage.rightAnchor.constraint(equalTo: coinPrice.leftAnchor,constant: -5).isActive = true
        coinStatusImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        coinStatusImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        coinImage.topAnchor.constraint(equalTo: coinName.bottomAnchor,constant: 5).isActive = true
        coinImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinSymbol.centerYAnchor.constraint(equalTo: coinImage.centerYAnchor).isActive = true
        coinSymbol.leftAnchor.constraint(equalTo: coinImage.rightAnchor,constant: 5).isActive = true
        coinSymbol.widthAnchor.constraint(equalToConstant: 30).isActive = true
        coinSymbol.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinRate.centerYAnchor.constraint(equalTo: coinImage.centerYAnchor).isActive = true
        coinRate.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        coinRate.widthAnchor.constraint(equalToConstant: 50).isActive = true
        coinRate.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func updateCellData(coin: Coin){
        coinName.text = coin.name
        coinPrice.text = "$" + String(round((Double(coin.price))!*100)/100)
        coinSymbol.text = coin.symbol
        coinRate.text = String(coin.change)
        changeColorForLabel()
        if coin.iconUrl == nil {
            self.coinImage.image = UIImage(named: "not_found")
        }else{
            self.coinImage.image = UIImage(named: coin.symbol)
        }
    }
    
    func changeColorForLabel(){
        if coinRate.text!.range(of:"-") != nil {
            coinRate.textColor = UIColor(named: "newRed")
            coinStatusImage.image = UIImage(named: "down")
            coinStatusImage.tintColor = UIColor(named: "newRed")
        }else{
            coinRate.textColor = UIColor(named: "newGreen")
            coinStatusImage.image = UIImage(named: "up")
            coinStatusImage.tintColor = UIColor(named: "newGreen")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
