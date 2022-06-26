//
//  TagCollectionViewCell.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation
import SnapKit
import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagCollectionViewCell"

    private lazy var tagTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .blue
        return label
    }()

    func setupCell(title: String) {
        setupViews()
        tagTitleLabel.text = title
    }
}

private extension TagCollectionViewCell {
    func setupViews() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        [
            tagTitleLabel
        ]
            .forEach {
                contentView.addSubview($0)
            }

        tagTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
