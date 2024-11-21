//
//  MovieTrailerConfigurator.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

protocol MovieTrailerConfiguratorProtocol: AnyObject {
    func configureMovieTrailerView(viewController: MovieTrailerViewController)
}

class MovieTrailerConfigurator: MovieTrailerConfiguratorProtocol {
    func configureMovieTrailerView(viewController: MovieTrailerViewController) {
        let router = MovieTrailerRouter()
        let presenter = MovieTrailerPresenter(andRouter: router)
        presenter.router = router
        viewController.presenter = presenter
    }
}
