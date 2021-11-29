//
//  WalletCell.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class WalletCell: UITableViewCell, HaveViewModelProtocol {
    typealias ViewModel = WalletCellViewModel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewModelChanged(_ viewModel: WalletCellViewModel) {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.ballance
    }
}
