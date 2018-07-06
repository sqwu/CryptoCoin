//
//  CoinCollectionExt.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coinCollection {
            return listOfCoins.count
        }else{
            return menuList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                if collectionView == coinCollection {
                let coin = listOfCoins[indexPath.row]
                let cell = coinCollection.dequeueReusableCell(withReuseIdentifier: coinCellId, for: indexPath) as! CoinCell
                cell.updateCellData(coin: coin)
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 5
                cell.layer.shadowRadius = 5
                cell.layer.shadowOpacity = 0.2
                return cell
        }else{
                let menu = menuList[indexPath.row]
                let cell = menuCollection.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
                cell.updateCellData(menu: menu)
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 5
                cell.layer.shadowRadius = 5
                cell.layer.shadowOpacity = 0.2
                    
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == coinCollection {
            let coin = listOfCoins[indexPath.row]
            updateInfo(coin: coin)
            animateInfoView()
            hideMenuIfVisible()
        }else{
            let menu = menuList[indexPath.row]
            let vc = UINavigationController(rootViewController: menu.viewController!)
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coinCollection {
        return CGSize(width: collectionView.frame.width - 10, height: 70)
        }else{
            return CGSize(width: 70, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == coinCollection {
            return UIEdgeInsets(top: 10, left: 15, bottom: 1, right: 15)
        }else{
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        }
    }
    
}
