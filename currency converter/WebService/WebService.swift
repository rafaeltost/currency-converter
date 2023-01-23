//
//  WebService.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import Foundation

protocol Service {
    func getCoins(pathParam:String, onCompletion: @escaping (ExchangeCoins?, String?) -> Void)
}

class WebService: Service {
    
    let urlBase:String = "https://economia.awesomeapi.com.br"
    
    public func getCoins(pathParam:String, onCompletion: @escaping (ExchangeCoins?, String?) -> Void) {
        let api:String = self.urlBase+"/json/last/"+pathParam
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.handle(data: data, response: (response as! HTTPURLResponse), error: error, onCompletion: onCompletion)
            }
        }.resume()
    }
}
private extension WebService {
    func handle(
        data: Data? = nil,
        response: HTTPURLResponse? = nil,
        error: Error? = nil,
        onCompletion: @escaping (ExchangeCoins?, String?) -> Void
    ) {
        if let data = data {
            if let apiResponse = try? JSONDecoder().decode(ExchangeCoins.self, from: data) {
                onCompletion(apiResponse, nil)
            } else if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                onCompletion(nil, error.message)
            } else {
                onCompletion(nil, "Parse Error")
            }
            
        } else if let error = error {
            print(error.localizedDescription)
            onCompletion(nil, nil)
        }
    }
    
}
