//
//  MovieTrailerRouterProtocolSpy.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp

class MovieTrailerRouterProtocolSpy: MovieTrailerRouterProtocol {
    // MARK: - Properties
    var didRouteToBack = false
    var viewMovie: MovieTrailerViewController? = nil
    
    // MARK: - Functions
    func routeToBack(viewMovie: MovieTrailerViewController) {
        self.didRouteToBack = true
        self.viewMovie = viewMovie
    }
}
