//
//  MarvelCollectionViewDataSourceSpec.swift
//  MarvelTests
//
//  Created by Nidhi Goyal on 06/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel

class MarvelCollectionViewDataSourceSpec: QuickSpec {
    override func spec() {
        describe("CharactersCollectionDatasource") {
            var controller: ViewController!
            var character: Marvel.Character!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "character", in: testBundle)
                character = Character.entity(withDictionary: (mockLoader?.json.object)!)!
                let networkHandler = MarvelNetworkHandlerMock(characters: [character])
                controller = Storyboard.Main.charactersViewControllerScene.viewController() as! ViewController
                
                let viewModel = MarvelViewModel (collectionView: controller.collectionView, tableView: controller.tableView, activityIndicator: controller.activityIndicator)
                
                viewModel.networkHandler = networkHandler
                controller.viewModel = viewModel
                
                //Load view components
                let _ = controller.view
                controller.showAsGrid(UIButton())
            }
            
            it("should have a valid datasource") {
                expect(controller.viewModel.collectionViewDataSource).toNot(beNil())
            }
            
            it("should have a cell of expected type") {
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = controller.viewModel.collectionViewDataSource!.collectionView(controller.collectionView, cellForItemAt: indexPath)
                expect(cell.isKind(of: CharacterCollectionCell.self)).to(beTruthy())
            }
            
            it("should have a configured cell") {
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = controller.viewModel.collectionViewDataSource!.collectionView(controller.collectionView, cellForItemAt: indexPath) as! CharacterCollectionCell
                let name = cell.name.text!
                expect(name).to(equal(character.name))
            }
            
            it("should have the right numberOfRowsInSection") {
                let count = controller.viewModel.collectionViewDataSource!.collectionView(controller.collectionView, numberOfItemsInSection: 0)
                expect(count).to(equal(1))
            }
        }
    }
}
