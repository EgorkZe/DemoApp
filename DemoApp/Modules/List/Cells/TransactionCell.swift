//
//  TransactionCell.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class TransactionCell: UITableViewCell, HaveViewModelProtocol {
    typealias ViewModel = TransactionCellViewModel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewModelChanged(_ viewModel: TransactionCellViewModel) {
        textLabel?.text = viewModel.paymentDetail
        detailTextLabel?.text = viewModel.amount
        detailTextLabel?.lineBreakMode = .byTruncatingMiddle
    }
}
