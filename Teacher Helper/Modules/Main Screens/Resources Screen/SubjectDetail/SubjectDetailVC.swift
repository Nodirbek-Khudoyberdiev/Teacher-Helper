//
//  SubjectDetailVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

class SubjectDetailVC: BaseViewController<SubjectDetailView> {

    let vm: [SubjectDetailVM] = [
        .init(grade: 5, gradeDescription: "Ресурсы за 5 класс", totalThemes: 12),
        .init(grade: 6, gradeDescription: "Ресурсы за 6 класс", totalThemes: 12),
        .init(grade: 7, gradeDescription: "Ресурсы за 7 класс", totalThemes: 12),
        .init(grade: 8, gradeDescription: "Ресурсы за 8 класс", totalThemes: 12),
        .init(grade: 9, gradeDescription: "Ресурсы за 9 класс", totalThemes: 12)
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
        mainView().delegate = self
        mainView().dataSource = self
        title = "Алгебра"
    }

}

extension SubjectDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubjectDetailCell = tableView.dequeueCell(for: indexPath)
        cell.configure(with: vm[indexPath.row])
        return cell
    }
    
}
