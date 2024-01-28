//
//  AppTabItemView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

class AppTabItemView: BaseView, TabItemProtocol {
    
    let title: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.build(font: .inter(font: .medium, size: 14),
                    color: .Gray._500,
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPrimaryColor
        return view
    }()
    
    init(title: String){
        self.title = title
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        addSubview(titleLabel)
    }
    
    func setupConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: TabItemProtocol
    
    func onSelected() {
        titleLabel.font = .inter(font: .semiBold, size: 14)
        titleLabel.textColor = .appPrimaryColor
        if borderView.superview == nil {
            addSubview(borderView)
            borderView.snp.makeConstraints({
                $0.left.right.bottom.equalToSuperview()
                $0.height.equalTo(2)
            })
        }
    }
    
    func onNotSelected() {
        titleLabel.textColor = .Gray._500
        titleLabel.font = .inter(font: .medium, size: 14)
        borderView.removeFromSuperview()
    }
}
