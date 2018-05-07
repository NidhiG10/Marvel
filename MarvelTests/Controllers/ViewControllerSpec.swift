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

class MarvelViewModelMock: MarvelViewModel {
    
}

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController") {
            var viewController: ViewController!
            var viewModel : MarvelViewModel!
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file:"character", in: testBundle)
                let character = Character.entity(withDictionary: (mockLoader?.json.object)!)!
                
                viewModel = MarvelViewModelMock()
                viewController = Storyboard.Main.charactersViewControllerScene.viewController() as! ViewController
                
                viewController.viewModel = viewModel
                viewController.subscribeViewModel()
                viewModel.process(characters: [character])
                
                //Load view components
                let _ = viewController.view
            }
            
            it("should have expected props setup") {
                viewController.viewDidLoad()
                expect(viewController.viewModel).toNot(beNil())
                expect(viewController.tableViewDataSource).toNot(beNil())
                expect(viewController.collectionViewDataSource).toNot(beNil())
                expect(viewController.searchBar).toNot(beNil())
                expect(viewController.activityIndicator).toNot(beNil())
                expect(viewController.tableView).toNot(beNil())
                expect(viewController.collectionView).toNot(beNil())
            }
            
            it("should use mock response on fetchCharacters") {
                viewController.viewDidLoad()
                let count = viewController.tableViewDataSource.characters?.count ?? 0
                expect(count).toEventually(equal(1))
            }
        }
    }
}
