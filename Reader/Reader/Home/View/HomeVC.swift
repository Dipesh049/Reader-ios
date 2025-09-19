//
//  HomeVC.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewNewsList: UITableView!
    
    //MARK: - Variables
    var viewModel: HomeViewModel!
    lazy var refreshControl = UIRefreshControl()
    let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarUI()
        viewModel = HomeViewModel()
        tblViewNewsList.register(UINib(nibName: NewsCell.reuseId, bundle: nil), forCellReuseIdentifier: NewsCell.reuseId)
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblViewNewsList.addSubview(refreshControl)
        
        viewModel.onChange = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tblViewNewsList.reloadData()
                self.refreshControl.endRefreshing()
            }
        }

        Task { await viewModel.loadFromApi()}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.filteredData(str: searchBarController.searchBar.text ?? "")
    }
    
    @objc func refresh(_ sender: AnyObject) {
        searchBarController.searchBar.text = ""
        Task { await viewModel.loadFromApi()}
    }
    
    func setSearchBarUI() {
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.sizeToFit()
        navigationItem.searchController = searchBarController
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filtered.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        let item = viewModel.filtered[indexPath.row]
        item.isBookmarked = viewModel.isBookmarked(article: item)
        cell.configure(with: item)
        cell.bookmarkClick = { [weak self] in
            self?.viewModel.bookmarkArticle(article: item)
        }
        return cell
    }

}

extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData(str: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        viewModel.filteredData(str: "")
    }
    
}
