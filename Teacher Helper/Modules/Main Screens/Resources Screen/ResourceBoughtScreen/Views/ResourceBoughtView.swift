//
//  ResourceBoughtView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourceBoughtView: BaseView {
    
    let tableView = ResourceBoughtTableView()
    
    lazy var plusButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    func setup() {
        addSubviews(tableView, plusButton)
    }
    
    func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.bottom.right.equalTo(-16)
            make.size.equalTo(56)
        }
    }
}

class ResourceBoughtTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        rowHeight = 128
        separatorStyle = .none
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
}
