//
//  LoginPresenterTests.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp
import XCTest

class LoginPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: LoginPresenter!
    var spyView: LoginViewControllerProtocolSpy!
    var spyRouter: LoginRouterProtocolSpy!
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupLoginPresenter()
    }
    
    override  func tearDown() {
        spyView = nil
        spyRouter = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupLoginPresenter() {
        spyView = LoginViewControllerProtocolSpy()
        spyRouter = LoginRouterProtocolSpy()
        sut = LoginPresenter(with: spyView, andRouter: spyRouter)
        sut.router = spyRouter
        sut.view = spyView
    }
    
    // MARK: - Tests
    func testValidateCredentials() {
        // Given
        let name: String = "Admin"
        let password: String = "Password*123."
        // When
        let validate: Bool = sut.validateCredentials(name: name, password: password)
        // Then
        XCTAssertNoThrow(validate, "validateCredentials executed")
        XCTAssertFalse(spyView.didShowModal, "didShowModal executed")
    }
    
    func testGoToListMovie() {
        // Given
        let name: String = "Admin"
        let password: String = "Password*123."
        // When
        sut.goToListMovie(name: name, password: password)
        // Then
        XCTAssertNoThrow(sut.goToListMovie(name: name, password: password), "goToListMovie executed")
        XCTAssertFalse(spyView.didShowToast, "didReloadData executed")
        XCTAssertNoThrow(spyView.didClearTextField, "didShowProgressView executed")
        XCTAssertNoThrow(spyRouter.didRouteToListMovie, "didRouteToListMovie executed")
    }
}
