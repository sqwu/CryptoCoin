//
//  NewsHandler.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC {
    @objc public func getDataNews(token: String?){
        self.news.removeAll()
        let url = URL(string: newsUrl + token!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK OF PICKERVIEW
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                    self.offlineLabel.isHidden = false
                    self.newsTable.isHidden = true
                }
                else{
                    if data != nil{
                        self.offlineLabel.isHidden = true
                        self.newsTable.isHidden = false
                        do {
                           let json = try JSONDecoder().decode(ArticleData.self, from: data!)
                            print(json)
                            self.news = json.articles
                            self.newsOffline = json.articles
                        }
                        catch{
                            print(Error.self)
                        }
                    }
                }
                self.newsTable.reloadData()
            }
        }
        task.resume()
    }
    
    @objc public func handleUpdate(){
        self.getDataNews(token: token)
    }
    
    @objc public func handleBack(){
        let vc = UINavigationController(rootViewController: MainVC())
        present(vc, animated: true, completion: nil)
    }
}
