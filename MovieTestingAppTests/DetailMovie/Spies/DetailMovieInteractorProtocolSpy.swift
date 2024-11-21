//
//  DetailMovieInteractorProtocolSpy.swift
//  MovieTestingAppTests
//
//  Created by Escurra Colquis
//

@testable import MovieTestingApp
import SwiftyJSON

class DetailMovieInteractorProtocolSpy: DetailMovieInteractorProtocol {
    // MARK: - Properties
    var didGetDetailMovie = false
    var presenter: DetailMoviePresenterProtocol?
    var url: String? = .empty
    var parameters: [String: Any]? = [String: Any]()
    var responseResult: ()
    var result: ResponseResult = .success(result: JSON(rawValue: JSON.self) ?? JSON())
    
    // MARK: - Functions
    func getDetailMovie(with url: String, parameters: [String: Any]?, completion: @escaping (ResponseResult) -> ()) {
        self.didGetDetailMovie = true
        self.url = url
        self.parameters = parameters
        self.responseResult = completion(result)
        return responseResult
    }
}
