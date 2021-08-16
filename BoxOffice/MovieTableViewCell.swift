//
//  MovieTableViewCell.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import SnapKit

class MovieTableViewCell: BaseTableViewCell {
    
    let thumbImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let gradeImageView: UIImageView = UIImageView()
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
            make.left.equalTo(contentView).offset(8)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(thumbImageView.snp.width)
        }
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(thumbImageView)
            make.left.equalTo(thumbImageView.snp.right).offset(10)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(infoLabel.snp.top).offset(-10)
            make.left.equalTo(infoLabel)
        }
        contentView.addSubview(gradeImageView)
        gradeImageView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(titleLabel.snp.height)
            make.height.equalTo(titleLabel)
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.left.equalTo(infoLabel)
        }
    }
}
