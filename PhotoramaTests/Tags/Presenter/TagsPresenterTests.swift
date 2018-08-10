//
//  TagsPresenterTests.swift
//  TagsPresenterTests
//
//  Created by juan sicilia on 6/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class TagsPresenterTests: XCTestCase {
    
    var presenter: TagsPresenter = TagsPresenter()
    var interactor: MockTagsInteractor = MockTagsInteractor()
    var view: MockTagsView = MockTagsView()
    var route: MockTagsRouter = MockTagsRouter()
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.view = view
        presenter.route = route
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        interactor.retrieveTagsIsBeenCalled = false
        route.dismissTagsVCCalled = false
    }
    
    func testPresenterViewDidLoadCallsInteractorRetrieveTags() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.retrieveTagsIsBeenCalled,"retrieveTagsIsBeenCalled should be false")
        XCTAssertNotNil(view.tags,"retrieveTagsIsBeenCalled should be false")
    }
    
    func testPresenterDidDoneTags() {
        let photo = TestHelpers.createGenericPhoto()
        presenter.didDoneTags(forPhoto: photo)
        XCTAssertEqual(interactor.photo,photo)
        XCTAssertTrue(route.dismissTagsVCCalled,"dismissTagsVCCalled should be false")
    }
    
    func testDidAddTag() {
        presenter.didAddTag()
        XCTAssertTrue(view.showAddTagAlerCalled,"showAddTagAlerCalled should be false")
    }
    
    func testDidSaveTags() {
        let newTag = "very-new-tag"
        presenter.didSave(tag: newTag)
        XCTAssertEqual(interactor.tags.count, 1, "Error we should have only 1 tags")
        XCTAssertEqual(interactor.tags.first, newTag, "Error tags doesnt correspond with the added one")
    }
    
    func testDidRetrievedTags() {
        let tags = TestHelpers.createRandomTags(amount: 10)
        presenter.didRetrievedTags(tags)
        XCTAssertEqual(view.tags, tags, "Error view tags should be the ones retrieved")
    }
    
}
