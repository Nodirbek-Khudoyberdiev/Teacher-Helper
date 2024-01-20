//
//  ResourceView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

final class ResourceView: BaseView {

    func setup() {
        addSubview(viewPager)
    }
    
    func setupConstrains() {
        viewPager.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 48, spacing: 0)
        )
        return viewPager
    }()
    
}
