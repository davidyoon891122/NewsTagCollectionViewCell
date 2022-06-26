//
//  Extension+String.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation

extension String {
    var htmlToString: String {
        guard let data = data(using: .utf8) else { return "" }

        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                         ],
                documentAttributes: nil).string
        } catch {
            return ""
        }
    }
}
