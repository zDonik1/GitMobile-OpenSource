//
//  KingfisherService.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Kingfisher
import RxSwift

class KingfisherService {
    
    static let shared = { KingfisherService() }()
    
    func loadImageFrom(urlString: String) -> Observable<Data> {
        
        return Observable.create { observer in
            
            if let url = URL(string: urlString) {
                ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        print("Data: \(value.originalData)")
                        observer.onNext(value.originalData)
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
