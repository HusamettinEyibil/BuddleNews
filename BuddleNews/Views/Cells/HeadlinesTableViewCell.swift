//
//  HeadlinesTableViewCell.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import UIKit

class HeadlinesTableViewCell: UITableViewCell {
    static let identifier = "HeadlinesTableViewCell"

    private let newsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.backgroundColor = .systemYellow
//        label.text = "dkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsdadkjsadkjasnsda"
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
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true

    }
    
    public func configure(with headline: String) {
        label.text = headline
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        label.text = nil
    }

}
