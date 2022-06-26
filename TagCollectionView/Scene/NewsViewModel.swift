//
//  NewsViewModel.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation
import RxSwift

protocol NewsViewModelInput {
    func requestNews(query: String, start: Int, display: Int)
}

protocol NewsViewModelOutput {
    var newsResponseSubject: PublishSubject<NewsResponseModel> { get set }
}

protocol NewsViewModelType {
    var inputs: NewsViewModelInput { get }
    var outputs: NewsViewModelOutput { get }
}


final class NewsViewModel: NewsViewModelType, NewsViewModelInput, NewsViewModelOutput {

    var inputs: NewsViewModelInput { self }

    var outputs: NewsViewModelOutput { self }

    var newsResponseSubject: PublishSubject<NewsResponseModel>

    private let disposeBag = DisposeBag()
    init() {
        newsResponseSubject = .init()
    }

    func requestNews(query: String, start: Int, display: Int) {
        NewsRepository().requestNews(query: query, start: start)
            .debug("requestNews")
            .subscribe(onNext: { news in
                self.newsResponseSubject.onNext(news)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }



}
