//
//  CategoryCell.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        contentView.backgroundColor = .clear
        addSubview(imageView)
        addSubview(categoryLabel)
        clipsToBounds = true
        layer.cornerRadius = contentView.height / 6
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 10, y: contentView.height/2 - 7,
                                 width: 14,
                                 height: 14)
        categoryLabel.frame = CGRect(x: imageView.right+7, y: 5,
                                     width: contentView.width-contentView.height-10,
                                     height: contentView.height-10)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    func configure(with labelText: String, _ isSelected: Bool) {
        categoryLabel.text = labelText
        setSelected(isSelected)
    }
    
    func setSelected(_ isSelected: Bool) {
        backgroundColor = isSelected ? .label : .systemBackground
        categoryLabel.textColor = isSelected ? .systemBackground : .label
        layer.borderColor = isSelected ? UIColor.systemBackground.cgColor : UIColor.label.cgColor
        imageView.image = UIImage(systemName: isSelected ? "checkmark" : "plus")
        imageView.tintColor = isSelected ? .systemBackground : .label
    }
}
