//
//  DetailMovieRepository.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import Foundation

protocol DetailMovieRepository: AnyObject {
    func getDetailMovie(with url: String, parameters: [String: Any]?, completion: @escaping (_ result: ResponseResult) -> ())
}
