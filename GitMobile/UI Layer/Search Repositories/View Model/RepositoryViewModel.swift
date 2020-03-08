//
//  RepositoryViewModel.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

final class RepositoryViewModel {
    
    private let disposeBag = DisposeBag()
    
    let title: String
    let description: String
    let avatarUrlString: String
    
    init(title: String, description: String, avatarUrlString: String) {
        self.title = title
        self.description = description
        self.avatarUrlString = avatarUrlString
    }
    
    func getImageData() -> Observable<Data> {
        
        return Observable.create { [unowned self] observer in
            
            KingfisherService.shared.loadImageFrom(urlString: self.avatarUrlString)
                .subscribe(onNext: { (data) in
                    observer.onNext(data)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
}
