//
//  MarvelCollectionDelegateSpec.swift
//  MarvelTests
//
//  Created by Nidhi Goyal on 08/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Marvel

class MarvelCollectionDelegateMock: CharactersDelegate {
    var didSelectRowTrigged = false
    
    func didSelectCharacter(at index: IndexPath) {
        didSelectRowTrigged = true
    }
}

class MarvelCollectionDelegateSpec: QuickSpec {
    override func spec() {
        describe("MarvelCollectionDelegate") {
            
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
            
            it("should have a valid delegate") {
                expect(controller.viewModel.collectionViewDelegate).toNot(beNil())
            }
            
            it("should have a cell of expected size") {
                let indexPath = IndexPath(row: 0, section: 0)
                let size = controller.viewModel.collectionViewDelegate!.collectionView(controller.collectionView, layout: controller.collectionView.collectionViewLayout, sizeForItemAt: indexPath)
                let width = controller.collectionView.bounds.size.width - 10.0
                let expectedSize = CharacterCollectionCell.size(for: width)
                expect(size.height).to(equal(expectedSize.height))
                expect(size.width).to(equal(expectedSize.width))
            }
            
            it("should call delegate on didSelectedRowAt") {
                let indexPath = IndexPath(row: 0, section: 0)
                let charactersDelegateMock = MarvelCollectionDelegateMock()
                controller.viewModel.collectionViewDelegate = MarvelCollectionDelegate(charactersDelegateMock)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beFalsy())
                controller.viewModel.collectionViewDelegate!.collectionView(controller.collectionView, didSelectItemAt: indexPath)
                expect(charactersDelegateMock.didSelectRowTrigged).to(beTruthy())
            }
            
            
            
        }
    }
}
