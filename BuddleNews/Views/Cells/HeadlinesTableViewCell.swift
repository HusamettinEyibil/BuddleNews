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
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
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
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
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
        newsImageView.sd_setImage(with: url, completed: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
    }

}
