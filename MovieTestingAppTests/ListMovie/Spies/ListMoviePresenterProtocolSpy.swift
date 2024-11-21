//
//  ListMoviePresenterProtocolSpy.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp

class ListMoviePresenterProtocolSpy: ListMoviePresenterProtocol {
    // MARK: - Properties
    var didGetListMovie = false
    var didHideProgress = false
    var didGoToDetailMovie = false
    var didGoToBack = false
    var page: Int?
    var totalPage: Int?
    var arrayUncomingMovie: [MovieResponse]?
    var arrayTopRatedMovie: [MovieResponse]?
    var arrayPopularMovie: [MovieResponse]?
    var type: TypeApi = .upcoming
    
    // MARK: - Functions
    func getListMovie(type: TypeApi, page: Int) {
        self.didGetListMovie = true
        self.type = type
        self.page = page
    }
    
    func hideProgress() {
        self.didHideProgress = true
    }
    
    func goToDetailMovie() {
        self.didGoToDetailMovie = true
    }
    
    func goToBack() {
        self.didGoToBack = true
    }
}
