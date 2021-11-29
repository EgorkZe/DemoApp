//
//  DetailViewModel.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class DetailViewModel: PerRequestProtocol {
    typealias Arguments = Transaction
    
    // MARK: - CONSTANTS
    
    enum Constants {
        static let sectionTitle = "Details:"
        static let cachedOut = "You've cashed out to"
        static let receivedPayment = "You've received payment"
        static let sender = "Sender"
        static let amount = "Amount"
    }
    
    var tableViewData: [DetailCellViewModel] = []
    var title = ""
    var sectionTitle = Constants.sectionTitle
    
    required init(container: ContainerProtocol, args: Transaction) {
        title = args.paymentDirection == .out ? "\(Constants.cachedOut) \(args.recipient)" : Constants.receivedPayment
        
        tableViewData = [DetailCellViewModel(title: Constants.sender, detail: args.sender),
                         DetailCellViewModel(title: Constants.amount, detail: args.amountWithCurrency)]
        
       
    }
}
