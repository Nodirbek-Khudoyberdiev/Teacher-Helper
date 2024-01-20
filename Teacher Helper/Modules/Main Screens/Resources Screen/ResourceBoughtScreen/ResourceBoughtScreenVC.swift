//
//  ResourceBoughtScreenVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourceBoughtScreenVC: BaseViewController<ResourceBoughtView> {
    
    let courseVM: [ResourcesVM] = [
        .init(courseTitle: "Алгебра", courseQuarter: "2 четверть", courseImage: UIImage(named: "Algebra")),
        .init(courseTitle: "Геометрия", courseQuarter: "2 четверть", courseImage: UIImage(named: "Geometry")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    private func setup(){
        mainView().tableView.delegate = self
        mainView().tableView.dataSource = self
    }
    
}

extension ResourceBoughtScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResourceBoughtCell = tableView.dequeueCell(for: indexPath)
        cell.setup(courseVM[indexPath.row])
        return cell
    }
    
}