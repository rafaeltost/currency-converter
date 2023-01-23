//
//  String.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import Foundation

extension String {
    public static func empty() -> String {
        return ""
    }
    
    public static func formatCurrency(value:NSNumber, enumCoin:String) -> String {
        let formatter = NumberFormatter()
        var locale:String = String.empty()
        
        switch enumCoin {
        case EnumCoins.USD.rawValue:
            locale = "en-US"
            break
        case EnumCoins.BRL.rawValue:
            locale = "pt-BR"
            break
        case EnumCoins.EUR.rawValue:
            locale = "pt-PT"
            break
        default:
            locale = "pt-BR"
        }
        
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value as NSNumber) {
            return formattedTipAmount
        }
        
        return String.empty()
    }
}

