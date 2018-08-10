//
//  TagsInteractorTests.swift
//  TagsInteractorTests
//
//  Created by juan sicilia on 6/8/18.
//  Copyright © 2018 juan sicilia. All rights reserved.
//

import XCTest

class TagsInteractorTests: XCTestCase {
    
    var interactor: TagsInteractor = TagsInteractor()
    var presenter: MockTagsPresenter = MockTagsPresenter()
    var store: MockPhotoStore = MockPhotoStore()
    
    
    override func setUp() {
        super.setUp()
        interactor.store = store
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        presenter.tags = nil
        store.getTagsSortedByNameCalled = false
        store.tags = []
        store.photo = nil
        super.tearDown()
    }
    
    func testRetrieveTags() {
        interactor.retrieveTags()
        XCTAssertTrue(store.getTagsSortedByNameCalled, "Error getTagsSortedByName isn't been called")
        XCTAssertNotNil(presenter.tags, "Error photoStore tags doesn't match retrieved tags")
    }
    
    func testSaveTag() {
        let newTag = "new tag"
        interactor.save(tag: newTag)
        XCTAssertEqual(store.tags[0], newTag, "Error tags hasn't been saved")
    }
    
    func testUpdatePhoto() {
        let photo = TestHelpers.createGenericPhoto()
        interactor.update(photo: photo)
        XCTAssertEqual(store.photo, photo, "Error store photo doesn't match the updated one")
    }
    
}
