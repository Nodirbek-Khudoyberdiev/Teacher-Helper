//
//  ResourceBoughtCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourceBoughtCell: BaseTableCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.borderRadius = 8
        view.backgroundColor = .Main._50
        return view
    }()
    
    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .bold, size: 18), color: .Main._600, lines: 1)
        return label
    }()
    
    lazy var courseQuarterLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .regular, size: 18), color: .Main._600, lines: 1)
        return label
    }()
    
    lazy var courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var courseMoreImageView = UIImageView()
    
    func setup() {
        courseMoreImageView.image = UIImage(named: "dots-vertical")
        courseMoreImageView.clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubviews(courseNameLabel, courseQuarterLabel, courseImageView, courseMoreImageView)
    }
    
    func setupConstrains() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        
        courseMoreImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.right.top.equalToSuperview().inset(16)
        }
        
        courseImageView.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        courseNameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(16)
            make.right.equalTo(courseMoreImageView.snp.left).offset(-4)
        }
        
        courseQuarterLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(courseNameLabel.snp.bottom).offset(5)
            make.right.equalTo(courseMoreImageView.snp.left).offset(-4)
        }
        
    }
    
    func setup(_ resourcesVM: ResourcesVM){
        courseNameLabel.text = resourcesVM.courseTitle
        courseQuarterLabel.text = resourcesVM.courseQuarter
        courseImageView.image = resourcesVM.courseImage
    }
}
