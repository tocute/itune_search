//
//  ViewModel.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func error(error: Error)
    func willLoadData()
    func didLoadData()
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    private var searchResponse: SearchResponse?
    private let iTunesUrlStr = "https://itunes.apple.com/search"
    private let lock = NSLock()
    
    func loadData(queryParameter: [String: String]) {
        if let url = URL(string: iTunesUrlStr) {
            delegate?.willLoadData()
            let queryParameterURL = url.appendQueryParameter(queryParameters: queryParameter)
            if lock.try() {
                URLSession.shared.dataTask(with: queryParameterURL, completionHandler: { [weak self] (data, response, error) in
                    if let error = error {
                        self?.delegate?.error(error: error)
                    } else {
                      if let data = data {
                          do {
                              self?.searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                          }  catch let jsonError {
                              self?.delegate?.error(error: jsonError)
                          }
                      }
                    }
                    self?.delegate?.didLoadData()
                }).resume()
                lock.unlock()
            }
        }
    }
    
    func numberOfSong() -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func getSelectedSong(at index: Int) -> SongItem? {
        guard let response = searchResponse else { return nil }
        guard response.results.indices.contains(index) else { return nil }
        
        return response.results[index]
    }
}
