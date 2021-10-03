//
//  MovieComentTableViewCell.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/16.
//

import UIKit
import SnapKit
import Cosmos

class MovieCommentTableViewCell: BaseTableViewCell {

    let profileImageView: UIImageView = UIImageView()
    let writerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
//    let ratingLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 10)
//        return label
//    }()
    let cosmosSetting: CosmosSettings = {
        var setting = CosmosSettings()
        setting.fillMode = .half
        setting.totalStars = 5
        setting.starSize = 10
        return setting
    }()
    lazy var cosmosView: CosmosView = CosmosView(settings: cosmosSetting)
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func setupCell() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(8)
            make.centerY.equalTo(contentView)
//            make.top.equalTo(contentView).offset(5)
//            make.bottom.equalTo(contentView).offset(-5)
            make.width.height.equalTo(40)
        }
        contentView.addSubview(writerLabel)
        writerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
//        contentView.addSubview(ratingLabel)
//        ratingLabel.snp.makeConstraints { (make) -> Void in
//            make.centerY.equalTo(writerLabel)
//            make.left.equalTo(writerLabel.snp.right).offset(10)
//        }
        contentView.addSubview(cosmosView)
        cosmosView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(writerLabel)
            make.left.equalTo(writerLabel.snp.right).offset(10)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(writerLabel.snp.bottom).offset(10)
            make.left.equalTo(writerLabel)
        }
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(writerLabel)
            make.right.equalTo(contentView).offset(-20)
        }
    }
}
