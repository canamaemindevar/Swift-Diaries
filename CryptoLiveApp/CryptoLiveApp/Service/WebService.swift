//
//  WebService.swift
//  CryptoLiveApp
//
//  Created by Emincan on 6.06.2022.
//

import Foundation
class  WebService {
    func downloadCurrencies(url : URL, completion : @escaping([CryptoCurrency]? )->()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil) // hata varsa completion nil veriyor data yok diyor
            } else if let data = data {
               let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                completion(cryptoList)
                // yada
                // if let cryptoList = cryptoList{
                // completion(cryptoList)}
            }
        }.resume()
    }
}
