//
//  DetailMovieUseCase.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import Foundation

protocol DetailMovieInteractorProtocol: AnyObject {
    var presenter: DetailMoviePresenterProtocol? { get set }
    func getDetailMovie(with url: String, parameters: [String: Any]?, completion: @escaping (_ result: ResponseResult) -> ())
}

class DetailMovieUseCase: DetailMovieInteractorProtocol {
    weak var presenter: DetailMoviePresenterProtocol?
    var repository: DetailMovieRepository?

    init(repository: DetailMovieRepository?) {
        self.repository = repository
    }
    
    func getDetailMovie(with url: String, parameters: [String : Any]?, completion: @escaping (ResponseResult) -> ()) {
        repository?.getDetailMovie(with: url, parameters: parameters, completion: completion)
    }
}
