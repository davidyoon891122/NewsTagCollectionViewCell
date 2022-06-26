//
//  NewsRepository.swift
//  TagCollectionView
//
//  Created by David Yoon on 2022/06/26.
//

import Foundation
import Alamofire
import RxSwift

final class NewsRepository {
    func requestNews(
        query: String,
        start: Int,
        display: Int = 20
    ) -> Observable<NewsResponseModel> {
        return Observable.create { emitter in
            guard let APIKey = self.getKeyFromAPIInfo(keyName: "NaverClientKey"),
                  let SecretKey = self.getKeyFromAPIInfo(keyName: "NaverSecretKey")
            else {
                return Disposables.create()
            }

            guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return Disposables.create() }

            let header: HTTPHeaders = [
                "X-Naver-Client-Id": APIKey,
                "X-Naver-Client-Secret": SecretKey
            ]

            let parameters = NewsRequestModel(query: query, start: start, display: display)

            AF.request(
                url,
                method: .get,
                parameters: parameters,
                headers: header
                )
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    emitter.onNext(result)
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    func getKeyFromAPIInfo(keyName: String) -> String? {
        if let path = Bundle.main.path(forResource: "APIKeyInfo", ofType: "plist") {
            let plist = NSDictionary(contentsOfFile: path)
            let key = plist?.object(forKey: keyName) as? String
            return key
        }
        return nil
    }
}

enum APIError: Error {
    case invalidPlist
}
