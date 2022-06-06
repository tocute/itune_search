//
//  URL+extension.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import Foundation

extension URL {
    func appendQueryParameter(queryParameters:[String: String]) -> URL {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        
        var queryItems = [URLQueryItem]()
        for (key, value) in queryParameters {
            let item = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(item)
        }        
        
        urlComponents.queryItems = queryItems
        
        guard let queryParameterURL = urlComponents.url else { return self }
        return queryParameterURL
    }
}
