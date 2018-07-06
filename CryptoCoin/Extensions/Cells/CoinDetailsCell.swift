//
//  CoinDetailsCell.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CoinDetailsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
  
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
    
    
    func setupView(){
  
        addSubview(coinImage)
        addSubview(coinSymbol)
        
        coinImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coinSymbol.centerYAnchor.constraint(equalTo: coinImage.centerYAnchor).isActive = true
        coinSymbol.leftAnchor.constraint(equalTo: coinImage.rightAnchor,constant: 5).isActive = true
        coinSymbol.widthAnchor.constraint(equalToConstant: 30).isActive = true
        coinSymbol.heightAnchor.constraint(equalToConstant: 20).isActive = true

    }
    
    func updateCellData(coin: Coin){
        coinSymbol.text = coin.symbol
        if coin.iconUrl == nil {
            self.coinImage.image = UIImage(named: "not_found")
        }else{
            self.coinImage.image = UIImage(named: coin.symbol)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
