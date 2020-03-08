//
//  NetworkClient.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire
import ObjectMapper

class NetworkClient {
    
    var baseURL: URL
    
    init(baseURL: String) {
        self.baseURL = URL(string: baseURL)!
    }
    
    func get<T: BaseMappable>(urlString: String,
                              parameters: Parameters = [:],
                              success: @escaping (Int, T) -> ()) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        guard let url = NSURL(string: urlString,
                              relativeTo: self.baseURL as URL?) else {
            return
        }
        
        let urlString = url.absoluteString!

        _ = request(.get,
                    urlString,
                    parameters: parameters,
                    headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response) in
                
                if let statusCode = response.response?.statusCode, let model = Mapper<T>().map(JSON: response.result.value as! [String : Any]) {
                    success(statusCode, model)
                }
                
            })
    }
    
    
}
