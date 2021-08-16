//
//  BaseTableViewCell.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import Reusable

class BaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func setupCell() {
        
    }
}
