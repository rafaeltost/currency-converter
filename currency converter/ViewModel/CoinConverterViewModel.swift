//
//  CoinConverterViewModel.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import Foundation

class CoinConverterViewModel {
    
    private let service: Service
    
    init(service: Service) {
        self.service = service
    }
            
    public func getCoins(params:String, onCompletion: @escaping (ExchangeCoins?, String?) -> Void) {
        self.service.getCoins(pathParam:params) { (data, error) in
            if let coins = data {
                onCompletion(coins, nil)
            } else {
                onCompletion(nil, error)
            }
        }
    }
    
    public func calculateCoins(valueInfo:String, valueCoin:String) -> NSNumber {
        let value:Float = Float(valueInfo)!
        let coin:Float = Float(valueCoin)!
        
        let calc:Float = coin * value
        
        return NSNumber(value: calc)
    }
    
    public func getListCoins() -> [String] {
        return EnumCoins.allCases.map {$0.rawValue}
    }
    
}
