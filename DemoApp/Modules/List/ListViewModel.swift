//
//  ListViewModel.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class ListViewModel: PerRequestProtocol, NotifyOnChangedProtocol {
    typealias Arguments = Void
    
    // MARK: - CONSTANTS
    
    enum Constants {
        static let historyTitle = "History"
        static let myWalletTitle = "My wallet"
        static let transactionCellID = "transaction"
        static let walletCellID = "wallet"
    }
    
    // MARK: - ENUM
    
    enum TableSection: Int {
        case wallets = 0
        case transactions
        
        var name: String {
            get {
                switch self {
                case .transactions:
                    return Constants.historyTitle
                case .wallets:
                    return Constants.myWalletTitle
                }
            }
        }
        
        var cellName: String {
            get {
                switch self {
                case .transactions:
                    return Constants.transactionCellID
                case .wallets:
                    return Constants.walletCellID
                }
            }
        }
    }
    
    // MARK: - PRIVATE FIELDS
    
    private var wallets: [WalletCellViewModel] = []
    private var transactions: [TransactionCellViewModel] = []
    
    private let listProvider: ListProvider
    private let presenter: PresenterService
    private var isWalletsLoading = false
    private var isTransactionsLoading = false
    
    var sections: [TableSection: [AnyViewModelProtocol]] = [.wallets: [], .transactions: []]
    var loadingError: Error?
    var isLoading: Bool {
        isWalletsLoading || isTransactionsLoading
    }
    
    required init(container: ContainerProtocol, args: Void) {
        listProvider = container.resolve()
        presenter = container.resolve()
    }
    
    // MARK: - REQUESTS
    
    func loadWallets() {
        isWalletsLoading = true
        listProvider.loadWallets() { [weak self] completionResult in
            switch completionResult {
            case .failure(let error):
                print(error)
                self?.loadingError = error
                self?.wallets = []
            case .success(let wallets):
                self?.loadingError = nil
                self?.wallets = wallets.map { WalletCellViewModel(wallet: $0) }
            }
            self?.isWalletsLoading = false
            self?.sections[.wallets] = self?.wallets ?? []
            self?.changed.raise()
        }
    }
    
    func loadTransactions() {
        isTransactionsLoading = true
        listProvider.loadTransactions() { [weak self] completionResult in
            switch completionResult {
            case .failure(let error):
                print(error)
                self?.loadingError = error
                self?.transactions = []
            case .success(let transactions):
                self?.loadingError = nil
                self?.transactions = transactions.map { TransactionCellViewModel(transaction: $0) }
            }
            self?.isTransactionsLoading = false
            self?.sections[.transactions] = self?.transactions ?? []
            self?.changed.raise()
        }
    }
    
    // MARK: - ROUTING
    
    func showTransactionDetails(forOrderIndex index: Int) {
        let transaction = transactions[index].transaction
        presenter.present(DetailView.self, args: transaction)
    }
}
