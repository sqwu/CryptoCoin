//
//  AboutVC.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Developed by:"
        return label
    }()
    
    lazy var developerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Uladzislau Daratsiuk"
        return label
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Project was created to provide for the end user in the easiest way information about different Cryptocurrencies from the whole world and display statistic for the different period of times"
        label.numberOfLines = 6
        return label
    }()
    
    lazy var emailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "email"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "facebook"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "twitter"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleTwitter), for: .touchUpInside)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    lazy var youtubeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "youtube"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleYoutube), for: .touchUpInside)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    lazy var rateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "rate"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleRate), for: .touchUpInside)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    lazy var copyRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Data provided by Coinranking"
        return label
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
    
    
    fileprivate func setupNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "About"
    }
    
    fileprivate func setupView(){

        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        developerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        developerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        developerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        developerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        developerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailButton.topAnchor.constraint(equalTo: developerLabel.bottomAnchor, constant: 150).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        rateButton.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        rateButton.rightAnchor.constraint(equalTo: facebookButton.leftAnchor, constant: -15).isActive = true
        rateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rateButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        twitterButton.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        twitterButton.leftAnchor.constraint(equalTo: emailButton.rightAnchor, constant: 15).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        facebookButton.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        facebookButton.rightAnchor.constraint(equalTo: emailButton.leftAnchor, constant: -15).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        youtubeButton.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        youtubeButton.leftAnchor.constraint(equalTo: twitterButton.rightAnchor, constant: 15).isActive = true
        youtubeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        youtubeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        backgroundImage.topAnchor.constraint(equalTo: youtubeButton.bottomAnchor,constant: 5).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: copyRightLabel.topAnchor, constant: -5).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 5).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        copyRightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        copyRightLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        copyRightLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        copyRightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        aboutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: developerLabel.bottomAnchor,constant: 5).isActive = true
        aboutLabel.bottomAnchor.constraint(equalTo: emailButton.topAnchor,constant: -20).isActive = true
        aboutLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        aboutLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(developerLabel)
        view.addSubview(emailButton)
        view.addSubview(facebookButton)
        view.addSubview(twitterButton)
        view.addSubview(rateButton)
        view.addSubview(youtubeButton)
        view.addSubview(copyRightLabel)
        view.addSubview(backgroundImage)
        view.addSubview(aboutLabel)
        setupNavBar()
        setupView()
        view.backgroundColor = .white
    }

}
