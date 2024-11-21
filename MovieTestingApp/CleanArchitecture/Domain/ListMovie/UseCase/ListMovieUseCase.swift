//
//  ListMovieUseCase.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import Foundation

protocol ListMovieInteractorProtocol {
    var presenter: ListMoviePresenterProtocol? { get set }
    func getListMovie(with url: String, parameters: [String: Any]?, completion: @escaping (_ result: ResponseResult) -> ())
}

class ListMovieUseCase: ListMovieInteractorProtocol {
    weak var presenter: ListMoviePresenterProtocol?
    var repository: ListMovieRepository?

    init(repository: ListMovieRepository?) {
        self.repository = repository
    }
    
    func getListMovie(with url: String, parameters: [String: Any]?, completion: @escaping (ResponseResult) -> ()) {
        repository?.getListMovie(with: url, parameters: parameters, completion: completion)
    }
}
