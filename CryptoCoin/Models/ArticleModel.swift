//
//  Article.swift
//  NewsReader
//
//  Created by Uladzislau Daratsiuk on 2018-04-17.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

struct ArticleData:Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
