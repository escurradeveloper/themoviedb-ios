//
//  ListMovieInteractor.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import Foundation
import Alamofire
import SwiftyJSON

class ListMovieInteractor: ListMovieInteractorProtocol {
    weak var presenter: ListMoviePresenterProtocol?
    
    func getListMovie(with url: String, parameters: [String: Any]?, completion: @escaping (_ result: ResponseResult) -> ()) {
        debugPrint("url: ",url)
        debugPrint("param: ",JSON(parameters ?? [:]))
        var finalURL = url
        for  param in parameters ?? [:] {
            finalURL  = finalURL.replacingOccurrences(of: "{\(param.key)}", with: "\(param.value)")
        }
        guard Utils.checkInternetConnection() else {
            self.presenter?.hideProgress()
            if let json  = UserDefaultMovie.getJSON(finalURL) {
                completion(.success(result: json))
            }
            Utils.showMessageTop(true, textBody: NSLocalizedString("verificatedInternet", comment: "verificatedInternet"))
            return
        }
        let request = AF.request(finalURL, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: HeaderAPI.headers())
        request.response {
            response in
            self.presenter?.hideProgress()
            if let jsonObject = response.value,  let objectResponse = jsonObject
            {
                let json = JSON(objectResponse)
                print(json)
                if response.response?.statusCode == ResponseCode.success {
                    UserDefaultMovie.saveJSON(json: json, key: finalURL)
                    completion(.success(result: json))
                } else {
                    completion(.failure(NSError(domain: json["status_message"].stringValue, code: json["status_code"].intValue, userInfo: [NSLocalizedDescriptionKey:json["status_message"].stringValue])))
                }
            } else if let error = response.error {
                completion(.failure(error as NSError))
            } else {
                Utils.showToast(message: NSLocalizedString("error", comment: "error"), duration: 3.0, position: .center)
            }
        }
        debugPrint(url)
    }
}
