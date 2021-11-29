//
//  DetailView.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class DetailView: UIViewController, HaveViewModelProtocol {
    typealias ViewModel = DetailViewModel
    
    // MARK: - CONSTANTS
    
    private enum Constants {
        static let backTitle = "Back"
        static let backCornerRadius: CGFloat = 10
        static let backBorderColor = UIColor.green.cgColor
        static let backBorderWidth: CGFloat = 1
        static let tableViewOffset: UIEdgeInsets = .init(top: 24, left: 16, bottom: -60, right: -16)
        static let titleOffset: UIEdgeInsets = .init(top: 24, left: 16, bottom: 0, right: -16)
        static let backButtonBottomOffset: CGFloat = -20
        static let backButtonSize = CGSize(width: 120, height: 60)
        static let detailReuseID = "DetailID"
    }
    
    // MARK: - PRIVATE FIELDS
    
    private lazy var titleLabel = UILabel()
    private lazy var tableView = UITableView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.backTitle, for: .normal)
        button.layer.borderColor = Constants.backBorderColor
        button.layer.borderWidth = Constants.backBorderWidth
        button.layer.cornerRadius = Constants.backCornerRadius
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupConstraints()
        setupTableView()
    }
    
    func viewModelChanged(_ viewModel: DetailViewModel) {
        titleLabel.text = viewModel.title
        tableView.reloadData()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(backButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleOffset.left),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.titleOffset.right),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleOffset.top)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewOffset.left),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.tableViewOffset.top),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.tableViewOffset.right),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.tableViewOffset.bottom)
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.backButtonBottomOffset),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonSize.width),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonSize.height)
        ])
    }
    
    private func setupTableView() {
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DetailCell.self, forCellReuseIdentifier: Constants.detailReuseID)
    }
    
    @objc private func back() {
        dismiss(animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension DetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension DetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableViewData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailReuseID, for: indexPath)
        if let cell = cell as? HaveAnyViewModelProtocol {
            cell.anyViewModel = viewModel?.tableViewData[indexPath.row]
        }
        return cell
    }
}
