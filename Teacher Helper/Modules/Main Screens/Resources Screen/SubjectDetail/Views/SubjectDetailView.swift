//
//  SubjectDetailView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

class SubjectDetailView: UITableView {
    
    private let inset: CGFloat = 16
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
 
    private func setup() {
        contentInset = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
        rowHeight = 64
        separatorStyle = .none
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
    }
    
}
