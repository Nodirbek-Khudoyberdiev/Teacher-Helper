//
//  MainResourcesBoughtController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

final class MainResourcesBoughtController: BaseViewController<UIView> {
    
    // MARK: Views
    
    private let header = MainResourcesBoughtSectionHeaderView()
    private let tableView = MainResourcesBoughtView()
    
    enum MainResourcesBoughtConstants {
        static let totalHeight: CGFloat = 116
        static let rowHeight: CGFloat = 84
        static let spacing: CGFloat = 12
        static let sectionHeaderHeight = totalHeight - rowHeight - spacing
    }
    
    let vm: [ResourcesBoughtResponse] = [
        .init(resourceName: "Алгебра", grade: "6 класс", quarter: [""]),
        .init(resourceName: "Алгебра", grade: "6 класс", quarter: [""]),
        .init(resourceName: "Алгебра", grade: "6 класс", quarter: [""]),
        .init(resourceName: "Алгебра", grade: "6 класс", quarter: [""])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubviews(header, tableView)
        
        view.snp.makeConstraints({
            $0.height.equalTo(MainResourcesBoughtConstants.totalHeight)
        })
        
        header.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(MainResourcesBoughtConstants.sectionHeaderHeight)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(header.snp.bottom).offset(MainResourcesBoughtConstants.spacing)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(MainResourcesBoughtConstants.rowHeight)
        })
    }
    
}

private extension MainResourcesBoughtController {
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainResourcesBoughtController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainResourcesBoughtTableCell = tableView.dequeueCell(for: indexPath)
        cell.vm = vm
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainResourcesBoughtConstants.rowHeight
    }
    
}
