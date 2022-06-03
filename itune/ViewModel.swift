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
    var searchResponse: SearchResponse?
    
    func loadData(term : String) {
        
        delegate?.willLoadData()
        let urlStr = "https://itunes.apple.com/search?term=\(term)&media=music"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                if let error = error {
                    self?.delegate?.error(error: error)
                } else {
                  if let data = data {
                      do {
                          self?.searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                      }  catch let jsonError {
                          self?.delegate?.error(error: jsonError)
                          print(jsonError.localizedDescription)
                      }
                  }
                }
                self?.delegate?.didLoadData()
            }).resume()
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
