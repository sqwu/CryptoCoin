//
//  DetailCollectionExt.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCoins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coin = listOfCoins[indexPath.row]
        let cell = coinCollection.dequeueReusableCell(withReuseIdentifier: coinCellId, for: indexPath) as! CoinDetailsCell
        cell.updateCellData(coin: coin)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 5
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let coin = listOfCoins[indexPath.row]
        updateInfo(coin: coin)
        uploadMonthHistory(coin: coin)
        uploadWeekHistory(coin: coin)
        uploadDayHistory(coin: coin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 1, right: 15)
    }
    
}

