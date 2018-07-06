//
//  NewsVC.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    let newsCellId = "newsCellId"
    let newsUrl = "https://newsapi.org/v2/top-headlines?sources=crypto-coins-news&apiKey="
    let token = "54fde7b8bbba4883abdf30f18bcea926"
    var news: [Article] = []
    var newsOffline: [Article] = []
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var newsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.backgroundColor = UIColor.white.withAlphaComponent(0)
        table.register(NewsCell.self, forCellReuseIdentifier: newsCellId)
        return table
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
    
    @objc fileprivate func setupView(){
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        
        newsTable.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        newsTable.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 10).isActive = true
        newsTable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -10).isActive = true
        newsTable.leftAnchor.constraint(equalTo: mainView.leftAnchor,constant: 1).isActive = true
        newsTable.rightAnchor.constraint(equalTo: mainView.rightAnchor,constant: -1).isActive = true
        
        offlineLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        offlineLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor,constant: 10).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor,constant: -10).isActive = true
        offlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"update"), style: .plain, target: self, action: #selector(handleUpdate))
        navigationController?.navigationBar.topItem?.title = "Crypto News"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.addSubview(newsTable)
        mainView.addSubview(offlineLabel)
        newsTable.delegate = self
        newsTable.dataSource = self
        setupView()
        setupNavBar()
        DispatchQueue.main.async {
            self.getDataNews(token: self.token)
        }
    }
}
