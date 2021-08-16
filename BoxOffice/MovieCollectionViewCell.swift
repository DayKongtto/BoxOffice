//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: BaseCollectionViewCell {
    let thumbImageView: UIImageView = UIImageView()
    let gradeImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override func setupCell() {
        contentView.addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-20)
            make.centerX.equalTo(contentView)
        }
        gradeImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(thumbImageView)
            make.right.equalTo(thumbImageView)
            make.left.equalTo(thumbImageView.snp.width).offset(40)
            make.height.equalTo(gradeImageView.snp.width)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(thumbImageView).offset(10)
        }
        infoLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(titleLabel).offset(10)
        }
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(infoLabel).offset(10)
        }
    }
}
