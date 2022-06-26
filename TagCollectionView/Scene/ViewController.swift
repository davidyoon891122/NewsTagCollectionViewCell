//
//  ViewController.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension ViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        [
            topView
        ]
            .forEach {
                view.addSubview($0)
            }

        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100.0)
        }
    }
}

