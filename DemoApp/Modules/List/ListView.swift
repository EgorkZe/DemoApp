//
//  ListView.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class ListView: UIViewController {
    typealias ViewModel = ListViewModel
    
    // MARK: CONSTANTS
    
    private enum Constants {
        static let pullToRefreshText = "Pull to refresh"
        static let alertTitle = "There is loading error"
        static let alertSubtitle = "Do you want to reload data?"
    }
    
    private lazy var tableView = UITableView()
    
    let refreshControl = UIRefreshControl()
    
    // MARK: LIFECYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - PRIVATE METHODS
    
    @objc private func loadData() {
        self.view.showLoading()
        self.viewModel?.loadTransactions()
        self.viewModel?.loadWallets()
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: Constants.pullToRefreshText)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(WalletCell.self, forCellReuseIdentifier: ListViewModel.TableSection.wallets.cellName)
        tableView.register(TransactionCell.self, forCellReuseIdentifier: ListViewModel.TableSection.transactions.cellName)
    }
    
}

// MARK: - HaveViewModelProtocol

extension ListView: HaveViewModelProtocol {
    func viewModelChanged(_ viewModel: ListViewModel) {
        if !viewModel.isLoading {
            view.hideLoading()
        }
        
        if viewModel.loadingError != nil{
            showAlert(title: Constants.alertTitle, message: Constants.alertSubtitle) { [weak self] in
                self?.loadData()
            }
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = ListViewModel.TableSection(rawValue: indexPath.section) ?? .transactions
        if section == .transactions {
            viewModel?.showTransactionDetails(forOrderIndex: indexPath.row)
        }
    }
}

// MARK: - UITableViewDataSource

extension ListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let name = ListViewModel.TableSection(rawValue: section)?.name
        guard let tableSection = ListViewModel.TableSection(rawValue: section) else {
            return ""
        }
        return viewModel?.sections[tableSection]?.count ?? 0 == 0 ? "" : name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableSection = ListViewModel.TableSection(rawValue: section) else {
            return 0
        }
        return viewModel?.sections[tableSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ListViewModel.TableSection(rawValue: indexPath.section) ?? .transactions
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellName, for: indexPath)
        if let cell = cell as? HaveAnyViewModelProtocol {
            cell.anyViewModel = viewModel?.sections[section]?[indexPath.row]
        }
        return cell
    }
}
