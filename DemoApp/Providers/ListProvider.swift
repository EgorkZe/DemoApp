//
//  ListProvider.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

/// Simple api provider which uses URLSession for requests.
class ListProvider: SingletonProtocol {
    typealias Arguments = Void
    
    /// You can easily change parameters of request use this link -  https://www.mockachino.com/spaces/4851c32b-ab3d-4f
    /// For example you can switch backend ressponse cod, for example 300 or 400 to get code error.
    enum APILinks: String {
        case transactions = "https://www.mockachino.com/4851c32b-ab3d-4f/histories"
        case wallets = "https://www.mockachino.com/4851c32b-ab3d-4f/wallets"
    }
    
    required init(container: ContainerProtocol, args: Void) {}
    
    func loadTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        let urlSession: URLSession = .shared
        let url = URL(string: APILinks.transactions.rawValue)!
        let task = urlSession.dataTask(with: url) { (transactionsResponse: TransactionsResponse?, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(transactionsResponse?.transactions ?? []))
            }
        }
        
        task.resume()
    }
    
    func loadWallets(completion: @escaping (Result<[Wallet], Error>) -> Void) {
        let urlSession: URLSession = .shared
        let url = URL(string: APILinks.wallets.rawValue)!
        let task = urlSession.dataTask(with: url) { (walletsResponse: WalletsResponse?, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(walletsResponse?.wallets ?? []))
            }
        }
        task.resume()
    }
}
