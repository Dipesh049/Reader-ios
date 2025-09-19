//
//  NewsCell.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let reuseId = "NewsCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var imgViewPoster: UIImageView!
    
    @IBOutlet weak var btnBookmark: UIButton!
    
    var bookmarkClick: (()-> ())?
    var isBookmarked: Bool = false {
        didSet {
            btnBookmark.setImage(UIImage(systemName: isBookmarked ? "bookmark.fill" : "bookmark"), for: .normal)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with article: Article) {
        title.text = article.title
        author.text = article.author
        Task {
            let data = try await NewsAPIClient.shared.downloadImage(urlStr: article.urlToImage)
            if let data {
                imgViewPoster.image = UIImage(data: data)
            }
        }
        isBookmarked = article.isBookmarked ?? false
    }
    
    func configure(with bookMarkArticle: NewsArticle) {
        title.text = bookMarkArticle.title
        author.text = bookMarkArticle.author
        Task {
            let data = try await NewsAPIClient.shared.downloadImage(urlStr: bookMarkArticle.imgUrl)
            if let data {
                imgViewPoster.image = UIImage(data: data)
            }
        }
        isBookmarked = true
    }
    
    override func prepareForReuse() {
        imgViewPoster.image = nil
        isBookmarked = false
    }
    
    
    @IBAction func btnBookmarkClick(_ sender: UIButton) {
        isBookmarked.toggle()
        bookmarkClick?()
    }
    
}
