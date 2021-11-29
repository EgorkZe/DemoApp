//
//  Wallet.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

struct Wallet: Decodable {
    let id: String
    let walletName: String
    let balance: String
    
    enum CodingKeys: String, CodingKey {
        case walletName = "wallet_name"
        case id
        case balance
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try! container.decode(String.self, forKey: .id)
        self.walletName = try! container.decode(String.self, forKey: .walletName)
        self.balance = try! container.decode(String.self, forKey: .balance)
    }
}
