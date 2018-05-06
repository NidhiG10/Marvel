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
//    var charactersArray: [Marvel.Character] = []
    
    func characters(query: String? = nil, completion: @escaping ([Marvel.Character]?) -> Void) {
        completion(characters)
    }
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
                viewModel.characters = [character]
                
                 viewController = Storyboard.Main.charactersViewControllerScene.viewController() as! ViewController
                viewController.viewModel = viewModel
                
                //Load view components
                let _ = viewController.view
            }
            
        }
    }
}
