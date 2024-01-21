//
//  ResourceAllView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourceAllView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        rowHeight = 85
        separatorStyle = .none
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
}
