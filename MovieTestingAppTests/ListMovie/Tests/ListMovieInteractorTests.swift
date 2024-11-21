//
//  ListMovieInteractorTests.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp
import XCTest

class ListMovieInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListMovieInteractor!
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupListMovieInteractor()
    }
    
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupListMovieInteractor() {
        sut = ListMovieInteractor()
    }
    
    // MARK: Tests
    func testGetPostListSuccess() {
        // Given
        let parameters: [String: Any]? = [String: Any]()
        let promise = expectation(description: "Status code: 200")
        // When
        sut.getListMovie(with: Constants.Urls.baseUrl + Constants.Urls.upcoming, parameters: parameters, completion: {
            result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                XCTFail("Status code: \(error.code)")
                return
            case .success(result: _):
                promise.fulfill()
                break
            }})
        //Then
        wait(for: [promise], timeout: 5)
    }
    
    func testGetPostListFailure() {
        // Given
        let parameters: [String: Any]? = [String: Any]()
        let promise = expectation(description: "Status code: 401")
        // When
        sut.getListMovie(with: Constants.Urls.baseUrl + Constants.Urls.upcoming, parameters: parameters, completion: {
            result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                XCTFail("Status code: \(error.code)")
                return
            case .success(result: _):
                promise.fulfill()
                break
            }})
        // Then
        wait(for: [promise], timeout: 15)
    }
}
