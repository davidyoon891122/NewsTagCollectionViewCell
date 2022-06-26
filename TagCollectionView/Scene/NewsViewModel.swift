//
//  NewsViewModel.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation
import RxSwift

protocol NewsViewModelInput {
    func requestNews(query: String, isNeedToReset: Bool)
}

protocol NewsViewModelOutput {
    var newsResponseSubject: PublishSubject<[News]> { get set }
}

protocol NewsViewModelType {
    var inputs: NewsViewModelInput { get }
    var outputs: NewsViewModelOutput { get }
}


final class NewsViewModel: NewsViewModelType, NewsViewModelInput, NewsViewModelOutput {

    var inputs: NewsViewModelInput { self }

    var outputs: NewsViewModelOutput { self }

    var newsResponseSubject: PublishSubject<[News]>

    private let disposeBag = DisposeBag()

    let display = 20

    var currentPage = 0

    private var newsList: [News] = []

    init() {
        newsResponseSubject = .init()
    }

    func requestNews(query: String, isNeedToReset: Bool) {

        if isNeedToReset {
            currentPage = 0
            newsList = []
        }


        NewsRepository().requestNews(
            query: query,
            start: (currentPage * display) + 1,
            display: display
        )
            .subscribe(onNext: { news in
                self.newsList += news.items
                self.currentPage += 1
                self.newsResponseSubject.onNext(self.newsList)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }



}
