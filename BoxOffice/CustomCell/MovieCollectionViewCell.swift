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
            make.bottom.equalTo(contentView).offset(-60)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.centerX.equalTo(contentView)
        }
        contentView.addSubview(gradeImageView)
        gradeImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(thumbImageView)
            make.right.equalTo(thumbImageView)
            make.width.height.equalTo(20)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(thumbImageView.snp.bottom).offset(10)
        }
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(thumbImageView)
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
        }
    }
}
