//
//  FruitCell.swift
//  loginScreen
//
//  Created by Mobicip on 27/04/26.
//

import UIKit

class FruitCell: UITableViewCell {
    
    let fruitImageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let arrowImageView = UIImageView()
    
    var isExpanded: Bool = false {
        didSet {
            priceLabel.isHidden = !isExpanded
            let imageName = isExpanded ? "chevron.up" : "chevron.down"
            arrowImageView.image = UIImage(systemName: imageName)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        let container = UIStackView(arrangedSubviews: [fruitImageView, stack, arrowImageView])
        container.axis = .horizontal
        container.spacing = 12
        container.alignment = .center
        
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            fruitImageView.widthAnchor.constraint(equalToConstant: 40),
            fruitImageView.heightAnchor.constraint(equalToConstant: 40),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        priceLabel.textColor = .gray
        priceLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with fruit: Fruit) {
        titleLabel.text = fruit.title
        priceLabel.text = fruit.price
        isExpanded = fruit.isExpanded
    }
    
    func setImage(_ image: UIImage?) {
        fruitImageView.image = image
    }
}
