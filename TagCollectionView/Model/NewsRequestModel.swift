//
//  NewsRequestModel.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation

struct NewsRequestModel: Codable {
    let query: String
    let start: Int
    let display: Int
}
