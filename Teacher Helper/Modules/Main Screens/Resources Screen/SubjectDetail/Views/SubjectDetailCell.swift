//
//  SubjectDetailCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

class SubjectDetailCell: BaseTableCell {
    
    lazy var gradeView = SubjectGradeView()
    
    lazy var containerView = UIView()
    
    lazy var subjectDetailLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .semiBold, size: 16),
                    color: .Gray._700,
                    lines: 1)
        return label
    }()
    
    lazy var themesLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .regular, size: 14),
                    color: .Gray._400,
                    lines: 1)
        return label
    }()
    
    private let inset: CGFloat = 16
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let edgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
        self.contentView.frame = self.contentView.frame.inset(by: edgeInsets)
    }
    
    func setup() {
        backgroundColor = .white
        contentView.addSubviews(gradeView, subjectDetailLabel, themesLabel)
    }
    
    func setupConstrains() {
        
        gradeView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.size.equalTo(48)
            make.centerY.equalToSuperview()
        }
        
        subjectDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(gradeView.snp.right).offset(16)
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview()
        }
        
        themesLabel.snp.makeConstraints { make in
            make.left.equalTo(gradeView.snp.right).offset(16)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview()
        }
        
    }
    
    func configure(with vm: SubjectDetailVM){
        self.subjectDetailLabel.text = vm.gradeDescription
        self.themesLabel.text = "\(vm.totalThemes) тем"
        self.gradeView.setSubject(with: vm.grade)
    }
    
}

class SubjectGradeView: BaseView {
    
    lazy var gradeLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .semiBold, size: 20),
                    color: .white,
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.height / 2
    }
    
    func setup() {
        backgroundColor = .appPrimaryColor
        addSubview(gradeLabel)
    }
    
    func setupConstrains() {
        gradeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setSubject(with grade: Int){
        gradeLabel.text = String(grade)
    }
    
}
