//
//  MenuCell.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let menuName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let menuImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
  
    
    func setupView(){
        addSubview(menuName)
        addSubview(menuImage)
        
        menuName.topAnchor.constraint(equalTo: menuImage.bottomAnchor,constant: 5).isActive = true
        menuName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menuName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        menuName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        menuImage.topAnchor.constraint(equalTo: self.topAnchor ,constant: 5).isActive = true
        menuImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menuImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        menuImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func updateCellData(menu: MenuModel){
        menuName.text = menu.title
        menuImage.image = menu.icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
