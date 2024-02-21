//
//  LessonScheduleHeaderView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/02/24.
//

import UIKit

class LessonScheduleHeaderView: UIView {
    
    enum LessonScheduleHeaderConstants {
        static let inset: CGFloat = 16
        static let contentHeight: CGFloat = 40
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel(text: "Четверг, 16 Ноября",
                            font: .inter(font: .semiBold, size: 18),
                            color: .Gray._500,
                            lines: 1,
                            alignment: .center)
        return label
    }()
    
    private let leftArrow: UIButton = {
        let button = UIButton()
        button.setImage(.chevronLeft, for: .normal)
        return button
    }()
    
    private let rightArrow: UIButton = {
        let button = UIButton()
        button.setImage(.chevronRight, for: .normal)
        return button
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
        setupConstraints()
    }
    
}

private extension LessonScheduleHeaderView {
    
    func setup(){
        addSubviews(leftArrow, dayLabel, rightArrow)
    }
    
    func setupConstraints(){
    
        leftArrow.snp.makeConstraints({
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        })
        
        rightArrow.snp.makeConstraints({
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        })
        
        dayLabel.snp.makeConstraints({
            $0.left.equalTo(leftArrow.snp.right).offset(5)
            $0.right.equalTo(rightArrow.snp.left).offset(5)
            $0.centerY.equalToSuperview()
        })
    }
    
    
}
