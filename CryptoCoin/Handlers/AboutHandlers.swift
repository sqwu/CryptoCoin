//
//  AboutHandlers.swift
//  CryptoCoin
//
//  Created by Uladzislau Daratsiuk on 7/1/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import StoreKit
import MessageUI

extension AboutVC {
    @objc public func handleBack(){
        let vc = UINavigationController(rootViewController: MainVC())
        present(vc, animated: true, completion: nil)
    }
    
    @objc public func handleEmail(){
        sendEmail()
    }
    
    @objc public func openButtonUrl(urlStr:String!) {
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    @objc public func handleFacebook(){
        openButtonUrl(urlStr: "https://www.facebook.com/Uladzislau-Daratsiuk-Swift-Developer-1565603270155394/")
    }
    
    @objc public func handleTwitter(){
        openButtonUrl(urlStr: "https://twitter.com/daratsiuk")
    }
    
    @objc public func handleYoutube(){
        openButtonUrl(urlStr: "https://www.youtube.com/c/iOSDeveloperUla")
    }
    
    @objc public func handleRate(){
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            Alert.showBasic(title: "Not available", msg: "Option available for devices on 10.3 or higher", vc: self)
        }
    }
    
    @objc public func handleShare(){
        let activityVC = UIActivityViewController(activityItems: ["Take a look on this amazing application about Crypto Coins"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

