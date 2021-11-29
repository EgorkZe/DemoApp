//
//  DetailCellModel.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class DetailCellViewModel: AnyViewModelProtocol {

    var title: String
    var detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}
