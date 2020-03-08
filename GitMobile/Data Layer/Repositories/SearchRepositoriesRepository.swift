//
//  SearchRepositoriesRepository.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

class SearchRepositoriesRepository {
    
    private let disposeBag = DisposeBag()
    let networkClient = NetworkClient(baseURL: BaseURLs.github)
    
    func searchRepositories(for query: String) -> Observable<[Repository]> {
        
        return Observable.create { [unowned self] observer in
            
            let parameters = [
                "q": query
                ] as [String : Any]
            
            self.networkClient.get(urlString: Endpoints.searchRepositories, parameters: parameters, success: { (code, searchResponse: SearchRepositoriesResponse) in
                if let repositories = searchResponse.items {
                    observer.onNext(repositories)
                }
            })
            
            return Disposables.create()
        }
    }
}
