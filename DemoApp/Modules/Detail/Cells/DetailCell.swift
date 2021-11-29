//
//  DetailCell.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class DetailCell: UITableViewCell, HaveViewModelProtocol {
    typealias ViewModel = DetailCellViewModel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - EMITED UPDATE EVENT
    
    func viewModelChanged(_ viewModel: DetailCellViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.detail
    }
}
