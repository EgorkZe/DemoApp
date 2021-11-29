//
//  Transaction.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

struct Transaction: Decodable {
    
    enum CashDirection {
        case income
        case out
    }
    
    let id: String
    let entry: String
    let amount: String
    let currency: String
    let sender: String
    let recipient: String
    
    var amountWithCurrency: String {
        "\(amount) \(currency)"
    }
    
    var paymentDirection: CashDirection {
        entry == "incoming" ? .income : .out
    }
}
