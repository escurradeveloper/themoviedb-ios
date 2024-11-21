//
//  ListMovieRepository.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import Foundation

protocol ListMovieRepository {
    func getListMovie(with url: String, parameters: [String: Any]?, completion: @escaping (_ result: ResponseResult) -> ())
}
