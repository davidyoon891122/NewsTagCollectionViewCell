//
//  NewsTableViewCell.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation
import UIKit
import SnapKit

final class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"

    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()

    private lazy var pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()

    func setupCell(title: String, pubDate: String) {
        setupViews()
        newsTitleLabel.text = title
        pubDateLabel.text = pubDate
    }
}

private extension NewsTableViewCell {
    func setupViews() {
        [
            newsTitleLabel,
            pubDateLabel
        ]
            .forEach {
                contentView.addSubview($0)
            }

        let inset: CGFloat = 16.0
        newsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8.0)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().offset(-inset)
        }

        pubDateLabel.snp.makeConstraints {
            $0.top.equalTo(newsTitleLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().offset(-inset)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
    }
}
