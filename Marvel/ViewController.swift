//
//  ViewController.swift
//  Marvel
//
//  Created by Nidhi Goyal on 28/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var searchBar:UISearchBar = {
        let sb = UISearchBar()
        sb.sizeToFit()
        sb.isTranslucent = true
        return sb
    }()
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let f = UICollectionViewFlowLayout()
        f.scrollDirection = UICollectionViewScrollDirection.vertical
        return f
    }()

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    fileprivate(set) lazy var viewModel: MarvelCharactersViewModel = {
        let viewModel = MarvelCharactersViewModel(collectionView: self.collectionView)
        viewModel.subscribe(withClosure: self.didReceiveViewModelMessageClosure())
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(self.collectionView)
        view.addSubview(self.activityIndicator)
        view.addSubview(self.searchBar)
        
        setupConstraints()
        
        viewModel.send(signal: .fetchCharacters(nil))
    }

    func setupConstraints() {
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }

    func hideNavigationBarActivityIndicator() {
        self.activityIndicator.startAnimating()
    }

}

/**
 MVVM Binding methods and definitions
 */
extension ViewController {
    
        func didReceiveViewModelMessageClosure() -> ((MarvelCharactersViewModel.Message) -> Void) {
            return { [weak self] message in
                switch message {
                case .charactersFetched:
                    self?.hideNavigationBarActivityIndicator()
                case .characterInfofetched:
                    self?.hideNavigationBarActivityIndicator()
                }
        }
    }
    
}


