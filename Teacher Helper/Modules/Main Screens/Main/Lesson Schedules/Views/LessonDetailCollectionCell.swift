//
//  LessonDetailCollectionCel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 18/02/24.
//

import UIKit

final class LessonDetailCollectionCell: UICollectionViewCell {
    
    // MARK: Public
    
    var viewModels: [LessonDetailVM]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Private
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.borderWidth = 1
        tableView.borderColor = .Gray._100
        tableView.borderRadius = 8
        tableView.separatorStyle = .none
        tableView.rowHeight = 56
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        return tableView
    }()
    
    // MARK: Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: Setup

private extension LessonDetailCollectionCell {

    func setup() {
        backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }
    
    func setupConstrains() {
        tableView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()//.inset(16)
        })
    }
    
}


// MARK: UITableViewDataSource

extension LessonDetailCollectionCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LessonDetailTableCell = tableView.dequeueCell(for: indexPath)
        cell.vm = viewModels?[indexPath.item]
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension LessonDetailCollectionCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
