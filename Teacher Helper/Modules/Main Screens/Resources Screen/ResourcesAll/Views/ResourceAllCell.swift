//
//  ResourceAllCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourceAllCell: BaseTableCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.borderRadius = 8
        view.backgroundColor = .Main._50
        return view
    }()
    
    lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .bold, size: 18), color: .Main._600, lines: 1)
        return label
    }()
    
    lazy var classesLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .regular, size: 18), color: .Main._600, lines: 1)
        return label
    }()
    
    lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .arrowRightImage
        imageView.clipsToBounds = true
        return imageView
    }()

    func setup() {
        backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.addSubviews(subjectLabel, classesLabel, arrowRightImageView)
    }
    
    func setupConstrains() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(8)
            make.bottom.equalToSuperview()
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.right.equalTo(arrowRightImageView.snp.left).offset(-4)
            make.height.equalTo(20)
        }
        
        classesLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(5)
            make.left.equalTo(16)
            make.right.equalTo(arrowRightImageView.snp.left).offset(-4)
            make.height.equalTo(20)
        }
        
        arrowRightImageView.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
    }
    
    func setup(with vm: ResourcesAllVM){
        subjectLabel.text = vm.courseName
        classesLabel.text = vm.courseClasses
    }
    
}
