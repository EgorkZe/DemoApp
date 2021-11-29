//
//  WalletCellViewModel.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class WalletCellViewModel: AnyViewModelProtocol {
    let wallet: Wallet
    
    var name: String {
        return "\(wallet.walletName)"
    }
    
    var ballance: String {
        return "\(wallet.balance)"
    }
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
