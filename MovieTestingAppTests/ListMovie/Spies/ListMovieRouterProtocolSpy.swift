//
//  ListMovieRouterProtocolSpy.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp

class ListMovieRouterProtocolSpy: ListMovieRouterProtocol {
    // MARK: - Properties
    var didRouteToDetailMovie = false
    var didRouteToBack = false
    var currentViewController: ListMovieViewController? = nil
    
    // MARK: - Functions
    func routeToDetailMovie() {
        self.didRouteToDetailMovie = true
    }
    
    func routeToBack() {
        self.didRouteToBack = true
    }
}
