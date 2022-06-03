//
//  ViewController.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var indication: UIActivityIndicatorView!
    let viewModel = ViewModel()
    let musicPlayer = MusicPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        viewModel.delegate = self
    }
}

// MARK: - UITableViewDataSource method
extension ViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSong()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if let song = viewModel.getSelectedSong(at: indexPath.row) {
            cell.textLabel?.text = song.trackName
        }

        
        return cell
    }

}

// MARK: - Table view UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // MARK: - Table view UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let song = viewModel.getSelectedSong(at: indexPath.row) {
            musicPlayer.playSong(musicURL: song.previewUrl)
        }
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            viewModel.loadData(term: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // hideKeyboard
        searchBar.resignFirstResponder()
    }
}

// MARK: - ViewModelDelegate
extension ViewController: ViewModelDelegate {
    func error(error: Error) {
        
    }
    
    func willLoadData() {
        DispatchQueue.main.async {
            self.indication.startAnimating()
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.indication.stopAnimating()
        }
    }
    
}
