//
//  WelcomeVC.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 6/29/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    lazy var mainIcon: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "main_icon")
        image.tintColor = UIColor(named: "system")
        return image
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "robot_icon")
        image.contentMode = .scaleAspectFit
        image.layer.shadowOpacity = 0.2
        image.layer.shadowRadius = 5
        return image
    }()
    
    lazy var appNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment  = .center
        label.font  = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.text = "CryptoCoin"
        return label
    }()
    
    lazy var sloganLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment  = .center
        label.font  = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.text = "Monitor & Track Crypto Currencies"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var sponsorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment  = .center
        label.font  = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.text = "Data provided by "
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var sponsorIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "coinranking_icon.png")
        return image
    }()
    
    lazy var getStartButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "system")
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("Get Started", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleStartButton), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setupView(){
        appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        appNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        mainIcon.centerYAnchor.constraint(equalTo: appNameLabel.centerYAnchor).isActive = true
        mainIcon.rightAnchor.constraint(equalTo: appNameLabel.leftAnchor,constant: -10).isActive = true
        mainIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        backgroundImage.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 50).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: -50).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        sloganLabel.bottomAnchor.constraint(equalTo: getStartButton.topAnchor, constant: -70).isActive = true
        sloganLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sloganLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        sloganLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sponsorLabel.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 10).isActive = true
        sponsorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sponsorLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        sponsorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sponsorIcon.centerYAnchor.constraint(equalTo: sponsorLabel.centerYAnchor).isActive = true
        sponsorIcon.leftAnchor.constraint(equalTo: sponsorLabel.rightAnchor,constant: 10).isActive = true
        sponsorIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sponsorIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        getStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        getStartButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        getStartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        getStartButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    fileprivate func addElements() {
        view.addSubview(mainIcon)
        view.addSubview(appNameLabel)
        view.addSubview(sloganLabel)
        view.addSubview(getStartButton)
        view.addSubview(backgroundImage)
        view.addSubview(sponsorLabel)
        view.addSubview(sponsorIcon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        view.backgroundColor = UIColor.white
        setupNavBar()
        setupView()
    }

}
