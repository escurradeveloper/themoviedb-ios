//
//  LoginPresenterProtocolSpy.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp

class LoginPresenterProtocolSpy: LoginPresenterProtocol {
    // MARK: - Properties
    var didValidateCredentials = false
    var didGoToListMovie = false
    var name: String? = .empty
    var password: String? = .empty
    
    // MARK: - Functions
    func validateCredentials(name: String?, password: String?) -> Bool {
        self.didValidateCredentials = true
        self.name = name
        self.password = password
        return true
    }
    
    func goToListMovie(name: String?, password: String?) {
        self.didGoToListMovie = true
        self.name = name
        self.password = password
    }
}
