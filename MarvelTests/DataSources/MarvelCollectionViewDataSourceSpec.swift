//
//  MarvelCollectionViewDataSourceSpec.swift
//  MarvelTests
//
//  Created by Nidhi Goyal on 06/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Quick
@testable import Marvel

class CharactersCollectionDatasourceSpec: QuickSpec {
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
                controller.viewModel.networkHandler = networkHandler
                
                //Load view components
                let _ = controller.view
                controller.showAsGrid(UIButton())
            }
            
        }
    }
}
