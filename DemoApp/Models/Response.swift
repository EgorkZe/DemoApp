//
//  Response.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

struct TransactionsResponse: Decodable {
    var transactions: [Transaction]? = []
    
    enum CodingKeys: String, CodingKey {
        case transactions = "histories"
    }
    
    init() {
        transactions = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.transactions = try container.decode([Transaction].self, forKey: .transactions)
    }
}

struct WalletsResponse: Decodable {
    var wallets: [Wallet]? = []
    
    enum CodingKeys: String, CodingKey {
        case wallets = "wallets"
    }
    
    init() {
        wallets = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wallets = try container.decode([Wallet].self, forKey: .wallets)
    }
}


