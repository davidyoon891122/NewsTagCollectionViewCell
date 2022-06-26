//
//  NewsViewController.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import UIKit
import SnapKit
import RxSwift

class NewsViewController: UIViewController {
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            TagCollectionViewCell.self,
            forCellWithReuseIdentifier: TagCollectionViewCell.identifier
        )
        collectionView.contentInset = UIEdgeInsets(
            top: 0.0,
            left: 8.0,
            bottom: 0,
            right: 8.0
        )
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()

    private let tagList = ["WWDC", "Apple", "iPhone", "개발자", "판교", "리뉴얼 앱", "한국투자증권", "알고리즘"]

    private let viewModel = NewsViewModel()

    private let disposeBag = DisposeBag()

    private var news: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.requestNews(query: "Apple", start: 1, display: 20)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return news.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        let item = news[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {

}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tagList.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.identifier,
            for: indexPath
        ) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = tagList[indexPath.row]
        cell.setupCell(title: title)
        return cell
    }


}

extension NewsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let title = tagList[indexPath.row]
        viewModel.inputs.requestNews(query: title, start: 1, display: 20)
    }

}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let label = UILabel()
        label.text = tagList[indexPath.row]
        label.font = .systemFont(ofSize: 14.0)
        label.sizeToFit()

        let size = label.frame.size
        return CGSize(width: size.width + 16, height: collectionView.frame.height - 10)
    }
}


private extension NewsViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        [
            topView,
            collectionView,
            newsTableView
        ]
            .forEach {
                view.addSubview($0)
            }

        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100.0)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50.0)
        }

        newsTableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

    }

    func bindViewModel() {
        viewModel.outputs.newsResponseSubject
            .subscribe(onNext: { [weak self] news in
                guard let self = self else { return }
                self.news = news.items
                self.newsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

