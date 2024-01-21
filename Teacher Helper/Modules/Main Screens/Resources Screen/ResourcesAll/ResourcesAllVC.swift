//
//  ResourcesAllVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit

class ResourcesAllVC: BaseViewController<ResourceAllView> {
    
    let resourcesAllVM: [ResourcesAllVM] = [
        .init(courseName: "Алгебра", courseClasses: "5-11 классы"),
        .init(courseName: "Геометря", courseClasses: "5-11 классы")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView().delegate = self
        mainView().dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
}

extension ResourcesAllVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourcesAllVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResourceAllCell = tableView.dequeueCell(for: indexPath)
        cell.setup(with: resourcesAllVM[indexPath.row])
        return cell
    }
    
}
