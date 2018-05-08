//
//  ViewControllerSpec.swift
//  MarvelTests
//
//  Created by Nidhi Goyal on 06/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel

struct MarvelNetworkHandlerMock: MavelNetworkHandlerProtocol {
    let characters: [Marvel.Character]
    func getCharacters(_ token: MarvelAPI, completion: @escaping ([Marvel.Character]?) -> Void) {
        completion(characters)
    }
}

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController") {
            var viewController: ViewController!
            var networkHandler : MavelNetworkHandlerProtocol!
            var viewModel : MarvelViewModel!
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file:"character", in: testBundle)
                let character = Character.entity(withDictionary: (mockLoader?.json.object)!)!
                
                networkHandler = MarvelNetworkHandlerMock(characters: [character])
                viewController = Storyboard.Main.charactersViewControllerScene.viewController() as! ViewController
                
                viewModel = MarvelViewModel (collectionView: viewController.collectionView, tableView: viewController.tableView, activityIndicator: viewController.activityIndicator)
                viewModel.networkHandler = networkHandler
                viewController.viewModel = viewModel
                
                //Load view components
                let _ = viewController.view
            }
            
            it("should have expected props setup") {
                viewController.viewDidLoad()
                expect(viewController.viewModel).toNot(beNil())
                expect(viewController.searchBar).toNot(beNil())
                expect(viewController.activityIndicator).toNot(beNil())
                expect(viewController.tableView).toNot(beNil())
                expect(viewController.collectionView).toNot(beNil())
            }
            
            it("should use mock response on fetchCharacters") {
                viewController.viewDidLoad()
                let count = viewController.viewModel.tableViewDataSource?.characters?.count ?? 0
                expect(count).toEventually(equal(1))
            }
            
            it("should be able to display content as tableView") {
                viewController.viewDidLoad()
                viewController.showAsTable(UIButton())
                expect(viewController.collectionView.isHidden).to(beTruthy())
                expect(viewController.tableView.isHidden).to(beFalsy())
            }
            
            it("should be able to display content as collectionView") {
                viewController.viewDidLoad()
                viewController.showAsGrid(UIButton())
                expect(viewController.tableView.isHidden).to(beTruthy())
                expect(viewController.collectionView.isHidden).to(beFalsy())
            }
            
            context("Empty search") {
                
                it("should not fetchCharacters when no searchTerm is provided") {
                    viewController.searchBar.text = ""
                    let searchBar = viewController.searchBar
                    viewController.viewModel.characters = []
                    viewController.searchBarSearchButtonClicked(searchBar)
                    expect(viewController.viewModel.characters.isEmpty).to(beTruthy())
                }
            }
            
            context("Not empty search") {
                
                it("should fetchCharacters when searchTerm is provided") {
                    viewController.searchBar.text = "searchThis"
                    let searchBar = viewController.searchBar
                    viewController.viewModel.characters = []
                    viewController.searchBarSearchButtonClicked(searchBar)
                    expect(viewController.viewModel.characters.isEmpty).to(beFalsy())
                }
            }
            
            it("should hide keyboard with click on searchbar cancel button") {
                let searchBar = viewController.searchBar
                searchBar.becomeFirstResponder()
                viewController.searchBarCancelButtonClicked(searchBar)
                expect(searchBar.isFirstResponder).to(beFalsy())
            }
            
            context("didSelectCharacter") {
                beforeEach {
                    let navController: UINavigationController = Storyboard.Main.initialViewController()
                    viewController = navController.viewControllers.first as! ViewController
                    viewController.viewModel = viewModel
                    let _ = viewController.view
                    viewController.viewDidLoad()
                }
                
                it("should navigate do next controller when selecting a character") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let controllerCounts =  viewController.navigationController?.viewControllers.count
                    expect(controllerCounts).to(equal(1))
                    viewController.viewModel.didSelectCharacter(at: indexPath)
                    expect(viewController.navigationController?.viewControllers.count ?? 0)
                        .toEventually(equal(2), timeout: 3)
                }
            }
        }
    }
}
