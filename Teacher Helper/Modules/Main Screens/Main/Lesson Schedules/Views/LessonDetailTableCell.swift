//
//  LessonDetailCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 18/02/24.
//

import UIKit

final class LessonDetailTableCell: UITableViewCell {
    
    enum LessonDetailConstants {
        static let inset: CGFloat = 16
        static let labelInset: CGFloat = 8
    }
    
    // MARK: Private
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray._100
        return view
    }()
    
    private let lessonOrderLabel: UILabel = {
        let label = UILabel(font: .inter(font: .regular, size: 20),
                            color: .Gray._400,
                            lines: 1,
                            alignment: .center)
        return label
    }()
    
    private let lessonDatesLabel: UILabel = {
        let label = UILabel(font: .inter(font: .semiBold, size: 16),
                            color: .Gray._500,
                            lines: 2,
                            alignment: .center)
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical,
                                    distribution: .fill,
                                    alignment: .fill,
                                    layoutMargins: nil)
        stackView.addArrangedSubview(lessonNameLabel)
        stackView.addArrangedSubview(lessonThemeLabel)
        return stackView
    }()
    
    private let lessonNameLabel: UILabel = {
        let label = UILabel(font: .inter(font: .bold, size: 16),
                            color: .Gray._500,
                            lines: 1,
                            alignment: .left)
        return label
    }()
    
    private let lessonThemeLabel: UILabel = {
        let label = UILabel(font: .inter(font: .regular, size: 14),
                            color: .Gray._500,
                            lines: 1,
                            alignment: .left)
        return label
    }()
    
    
    private let hStackView: UIStackView = {
        let margins = UIEdgeInsets(top: 0,
                                   left: 0,
                                   bottom: LessonDetailConstants.inset,
                                   right: LessonDetailConstants.labelInset)
        let stackView = UIStackView(axis: .horizontal,
                                    distribution: .fill,
                                    alignment: .center,
                                    layoutMargins: margins,
                                    spacing: 10)
        return stackView
    }()
    
    private let classLabel: PaddingLabel = {
        let label = PaddingLabel(withInsets: LessonDetailConstants.labelInset,
                                 LessonDetailConstants.labelInset,
                                 LessonDetailConstants.labelInset, 
                                 LessonDetailConstants.labelInset)
        label.build(font: .inter(font: .regular, size: 20),
                    color: .Main._500,
                    lines: 1,
                    alignment: .center)
        label.backgroundColor = .Main._50
        label.cornerRadius = 8
        return label
    }()
    
    // MARK: Public
    
    var vm: LessonDetailVM? {
        didSet {
            classLabel.text = vm?.className
            lessonNameLabel.text = vm?.lessonName
            lessonThemeLabel.text = vm?.lessonTheme
            lessonDatesLabel.text = (vm?.lessonStartDate ?? "") + "\n" + (vm?.lessonEndDate ?? "")
            lessonOrderLabel.text = vm?.lessonOrder.toString
        }
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        classLabel.text = nil
        lessonNameLabel.text = nil
        lessonThemeLabel.text = nil
        lessonDatesLabel.text = nil
        lessonOrderLabel.text = nil
    }
    
}

// MARK: View setup

private extension LessonDetailTableCell {
    func setup(){
        selectionStyle = .none
        hStackView.addArrangedSubview(lessonOrderLabel)
        hStackView.addArrangedSubview(lessonDatesLabel)
        hStackView.addArrangedSubview(vStackView)
        addSubview(bottomLineView)
        contentView.addSubviews(hStackView, classLabel)
        backgroundColor = .clear
    }
    
    func setupConstraints(){
        classLabel.snp.makeConstraints({
            $0.right.equalToSuperview().inset(LessonDetailConstants.inset)
            $0.centerY.equalToSuperview()
        })
        
        hStackView.snp.makeConstraints({
            $0.left.equalToSuperview().inset(LessonDetailConstants.inset)
            $0.top.equalTo(LessonDetailConstants.labelInset)
            $0.right.lessThanOrEqualTo(classLabel.snp.left).inset(LessonDetailConstants.labelInset)
        })
        
        bottomLineView.snp.makeConstraints({
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        })
        
    }
}
