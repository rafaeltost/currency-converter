//
//  ExchangeUserDefault.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import Foundation

class ExchangeUserDefault {
    
    let kHistory:String = "kHistory"
    
    public func save(listCoins:[Coin]) {
        do {
            let list = try JSONEncoder().encode(listCoins)
            UserDefaults.standard.setValue(list, forKey: self.kHistory)
        } catch {
            print(error)
        }
    }
    
    public func getListCoins() -> [Coin]{
        do {
            guard let list = UserDefaults.standard.object(forKey: self.kHistory) else { return []}
            let listAux = try JSONDecoder().decode([Coin].self, from: list as! Data)
            
            return listAux
        } catch {
            print(error)
        }
        
        return []
    }
}
