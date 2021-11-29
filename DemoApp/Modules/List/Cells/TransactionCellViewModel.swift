//
//  TransactionCellViewModel.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class TransactionCellViewModel: AnyViewModelProtocol {
    let transaction: Transaction
    
    // MARK: - CONSTANTS
    
    enum Constants {
        static let cashedOut = "You've cashed out to"
        static let receivedPayment = "You've received payment"
    }
    
    var paymentDetail: String {
        transaction.paymentDirection == .out ? "\(Constants.cashedOut) \(transaction.recipient)" : Constants.receivedPayment
    }
    
    var amount: String {
        transaction.amountWithCurrency
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
