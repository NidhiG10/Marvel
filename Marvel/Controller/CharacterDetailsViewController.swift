    //
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var character: Character?
}

extension CharacterDetailsViewController {
    
    convenience init(character: Character?) {
        self.init()
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        view.addSubview(self.imageView)
        view.addSubview(self.bottomView)
        self.bottomView.addSubview(self.name)
        
        addContraints()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = character?.name ?? ""
    }
}


extension CharacterDetailsViewController {
    func setupView() {
        let bio = character?.bio ?? ""
        self.name.text = bio.isEmpty ? "No description" : bio
        self.imageView.download(image: character?.image?.fullPath() ?? "")
    }
    
    func addContraints() {
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        
        name.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
}
