//
//  PokeTableViewCell.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    
    private lazy var descriptionLabel: PokeTitleLabel = {
        var label = PokeTitleLabel()
        self.contentView.addSubview(label)
        return label
    }()
    private lazy var pokeImageView: PokeImageView = {
        let imageView = PokeImageView(frame: .zero)
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        pokeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        pokeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        pokeImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pokeImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: pokeImageView.leftAnchor, constant: 0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(image: UIImage, description: String) {
        descriptionLabel.text = description
        pokeImageView.image = image
    }
}
