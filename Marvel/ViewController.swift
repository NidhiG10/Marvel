//
//  ViewController.swift
//  Marvel
//
//  Created by Nidhi Goyal on 28/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isShowingList = true
    
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
    
    fileprivate(set) lazy var viewModel: MarvelViewModel = {
        let viewModel = MarvelViewModel()
        viewModel.subscribe(withClosure: self.didReceiveViewModelMessageClosure())
        return viewModel
    }()
    
    fileprivate(set) lazy var collectionViewDataSource: MarvelCollectionDataSource = {
        let ds = MarvelCollectionDataSource(collectionView: self.collectionView)
        return ds
    }()
    
    fileprivate(set) lazy var tableViewDataSource: MarvelTableDataSource = {
        let ds = MarvelTableDataSource(tableView: self.tableView)
        return ds
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.edgesForExtendedLayout = [];
        view.addSubview(self.collectionView)
        view.addSubview(self.tableView)
        view.addSubview(self.activityIndicator)
        view.addSubview(self.searchBar)
        
        self.searchBar.delegate = self.viewModel
        self.collectionView.delegate = self.viewModel
        self.tableView.delegate = self.viewModel
        
        setupConstraints()
        
        self.viewModel.send(signal: .fetchCharacters(nil))
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
    
    func reloadData(characters: [Character]) {
        self.activityIndicator.stopAnimating()
        if isShowingList {
            self.tableView.isHidden = false
            self.tableViewDataSource.process(characters: characters)
        } else {
            self.collectionView.isHidden = false
        }
    }
    
    func showCharacterDetails(_ character:Character) {
        self.searchBar.resignFirstResponder()
        let characterDetailsVC = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(characterDetailsVC, animated: true)
    }

}

extension ViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
    }
}

/**
 MVVM Binding methods and definitions
 */
extension ViewController {
    
        func didReceiveViewModelMessageClosure() -> ((MarvelViewModel.Message) -> Void) {
            return { [weak self] message in
                switch message {
                case .fetchingCharacters:
                    self?.startAnimatingActivityIndicator()
                case let .charactersFetched(characters):
                    self?.reloadData(characters: characters)
                case let .showCharacterDetails(character):
                    self?.showCharacterDetails(character)
                }
        }
    }
    
}


