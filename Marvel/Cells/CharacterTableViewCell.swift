//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var thumbnailImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(rightView)
        rightView.addSubview(name)
        addContraints()
    }
    
    func addContraints() {
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        rightView.leadingAnchor.constraint(equalTo: self.thumbnailImageView.trailingAnchor, constant:10.0).isActive = true
        rightView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        rightView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        name.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
    }
    
    // MARK: - Public methods
    
    func configure(withCharacter character: Character) {
        name.text = character.name
        thumbnailImageView.download(image: character.image?.fullPath() ?? "")
    }
    
    static func height() -> CGFloat {
        return 80
    }
    
}
