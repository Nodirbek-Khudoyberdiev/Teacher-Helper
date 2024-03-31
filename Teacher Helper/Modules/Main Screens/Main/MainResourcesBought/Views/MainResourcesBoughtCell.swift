//
//  MainResourcesBoughtCollectionCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

class MainResourcesBoughtCollectionCell: BaseCollectionCell {
    
    enum MainResourcesBoughtCellConstants {
        static let margin: CGFloat = 8
    }
    
    var vm: ResourcesBoughtResponse? {
        didSet {
            courseNameLabel.text = vm?.resourceName
            gradeLabel.text = vm?.grade
            quarterLabel.text = "1,2,3 четверть"
        }
    }
    
    private lazy var topOfView: UIView = {
        let view = UIView()
//        view.clipsToBounds = true
        view.backgroundColor = .Main._500
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let margin = MainResourcesBoughtCellConstants.margin
        let margins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        let stackView = UIStackView(axis: .vertical,
                                    distribution: .fill,
                                    alignment: .fill,
                                    layoutMargins: margins,
                                    spacing: 4)
        return stackView
    }()
    
    private lazy var courseNameLabel: UILabel = {
        let label = UILabel(font: .inter(font: .medium, size: 16),
                            color: .Gray._600,
                            lines: 1)
        return label
    }()
    
    private lazy var gradeLabel: UILabel = {
        let label = UILabel(font: .inter(font: .medium, size: 14),
                            color: .Gray._500,
                            lines: 1)
        return label
    }()
    
    private lazy var quarterLabel: UILabel = {
        let label = UILabel(font: .inter(font: .regular, size: 14),
                            color: .Gray._400,
                            lines: 1)
        return label
    }()

    func setup() {
        contentView.borderRadius = 8
        contentView.borderWidth = 1
        contentView.borderColor = .Gray._100
        
        [courseNameLabel, gradeLabel, quarterLabel].forEach({
            contentStackView.addArrangedSubview($0)
        })
        
        contentView.addSubviews(topOfView, contentStackView)
    }
    
    func setupConstrains() {
        topOfView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(8)
        })
        
        contentStackView.snp.makeConstraints({
            $0.top.equalTo(topOfView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
}
