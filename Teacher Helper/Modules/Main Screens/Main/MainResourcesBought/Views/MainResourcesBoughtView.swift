//
//  MainResourcesBoughtView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

final class MainResourcesBoughtView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        clipsToBounds = false
        isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
