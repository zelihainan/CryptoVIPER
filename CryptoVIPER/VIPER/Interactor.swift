//
//  Interactor.swift
//  CryptoVIPER
//
//  Created by Zeliha İnan on 27.08.2025.
//

import Foundation

protocol AnyInteractor {
    var presenter : AnyPresenter? { get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.presenter?.interactiveDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                DispatchQueue.main.async {
                    self.presenter?.interactiveDidDownloadCrypto(result: .success(cryptos))
                }
            } catch {
                self.presenter?.interactiveDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
}
