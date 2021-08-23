//
//  BaseCollectionViewCell.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import Reusable

class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func setupCell() {
        
    }
}
