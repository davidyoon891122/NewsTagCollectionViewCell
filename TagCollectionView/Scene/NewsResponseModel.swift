//
//  NewsModel.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation

struct NewsResponseModel: Decodable {
    var items: [News] = []
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
