//
//  HeadlinesTableViewCell.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import UIKit
import SDWebImage

class HeadlinesTableViewCell: UITableViewCell {
    static let identifier = "HeadlinesTableViewCell"

    private let newsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.backgroundColor = .systemBackground
        label.textAlignment = .right
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
                
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: contentView.width/3).isActive = true
        
        contentView.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    public func configure(with headline: HeadlinesViewModel) {
        titleLabel.text = headline.title
        guard let url = URL(string: headline.imageURL) else {
            newsImageView.image = UIImage(systemName: "photo")
            return
        }
        newsImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        dateLabel.text = Date.utcToLocal(dateStr: headline.articleDate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }

}
