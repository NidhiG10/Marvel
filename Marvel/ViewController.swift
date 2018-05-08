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
        sb.showsCancelButton = true
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
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 44
        return tv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    var viewModel: MarvelViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.edgesForExtendedLayout = [];
        view.addSubview(self.collectionView)
        view.addSubview(self.tableView)
        view.addSubview(self.activityIndicator)
        view.addSubview(self.searchBar)
        
        setupConstraints()
        
        viewModel = viewModel ?? MarvelViewModel.init(collectionView: self.collectionView, tableView: self.tableView, activityIndicator: self.activityIndicator)
        viewModel.showCharacterDetails = {[weak self]
            (character) -> Void in
            self?.showCharacterDetails(character)
        }

        self.searchBar.delegate = self
        self.viewModel.fetchCharacters(query: nil)
    }

    func setupConstraints() {
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }

    func startAnimatingActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
    }

    func showCharacterDetails(_ character:Character) {
        self.searchBar.resignFirstResponder()
        let characterDetailsVC = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(characterDetailsVC, animated: true)
    }

}

extension ViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        self.viewModel.showAsGrid(value: true)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        self.viewModel.showAsGrid(value: false)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            self.startAnimatingActivityIndicator()
            self.viewModel.fetchCharacters(query: query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



