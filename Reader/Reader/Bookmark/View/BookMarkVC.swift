//
//  BookMarkVC.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import UIKit

class BookMarkVC: UIViewController {
    
    //MARK: - IBOUtlets
    @IBOutlet weak var tblViewNewsList: UITableView!
    
    //MARK: - Variables
    var viewModel: BookmarksViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BookmarksViewModel()
        tblViewNewsList.register(UINib(nibName: NewsCell.reuseId, bundle: nil), forCellReuseIdentifier: NewsCell.reuseId)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadBookmarkArticle()
        tblViewNewsList.reloadData()
    }

}

//MARK: - UITableViewDataSource
extension BookMarkVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        let item = viewModel.allSources[indexPath.row]
        cell.configure(with: item)
        cell.bookmarkClick = { [weak self] in
            self?.viewModel.updateBookmark(article: item, index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return cell
    }
}

extension BookMarkVC: UITableViewDelegate {
    
}
