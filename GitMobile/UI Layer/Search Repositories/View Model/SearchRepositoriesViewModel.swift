//
//  SearchRepositoriesViewModel.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

protocol SearchRepositoriesViewModelFactory {
    func makeViewModel() -> SearchRepositoriesViewModel
}

final class SearchRepositoriesViewModel {
    
    // MARK: - State
    let isSearching = BehaviorSubject<Bool>(value: false)
    let isLoading = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let repository = SearchRepositoriesRepository()
    let repositoryViewModels = BehaviorSubject<[RepositoryViewModel]>(value: [])
    
    // MARK: - Methods
    func searchRepositories(for query: String) {
        self.isLoading.onNext(true)
        
        repository.searchRepositories(for: query)
            .subscribe(onNext: { [weak self] (repositories) in
                
                self?.isLoading.onNext(false)
                
                let viewModels = repositories.map {
                    RepositoryViewModel(title: $0.name,
                                        description: $0.description,
                                        avatarUrlString: $0.avatar_url)
                }
                
                self?.repositoryViewModels.onNext(viewModels)
            })
            .disposed(by: disposeBag)
        
    }
}
