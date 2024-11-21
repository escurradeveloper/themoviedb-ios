//
//  LoginConfigurator.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

protocol LoginConfiguratorProtocol: AnyObject {
    func configureLoginView(viewController: LoginViewController)
}

class LoginConfigurator: LoginConfiguratorProtocol {
    func configureLoginView(viewController: LoginViewController) {
        let router = LoginRouter(with: viewController)
        let presenter = LoginPresenter(with: viewController, andRouter: router)
        viewController.presenter = presenter
    }
}
