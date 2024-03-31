//
//  MainResourcesBoughtSectionHeaderView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

class MainResourcesBoughtSectionHeaderView: BaseView {
    
    let view = TitleWithImageButton()
    
    func setup() {
        view.setTitle("Купленные ресурсы")
        view.setImage(.chevronDown)
        addSubview(view)
    }
    
    func setupConstrains() {
        view.snp.makeConstraints({
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        })
    }
    
}
