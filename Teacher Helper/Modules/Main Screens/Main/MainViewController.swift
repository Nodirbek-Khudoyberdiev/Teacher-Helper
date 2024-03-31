//
//  MainViewController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView> {
    
    // MARK: Lifecycle
    
    private let lessonScheduleVC = LessonSchedulesViewController()
    private let boughtResourcesVC = MainResourcesBoughtController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavbarButtons()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
}

// MARK: Actions

private extension MainViewController {
    
    @objc private func menuAction(){
        
    }
    
    @objc private func alertAction(){
        
    }
}

// MARK: Setup

private extension MainViewController {
    
    func setup(){
        navigationItem.title = "Teacher Assistant"
        addChildVC(boughtResourcesVC)
        addChildVC(lessonScheduleVC)
        mainView().contentStackView.addArrangedSubview(boughtResourcesVC.view)
        mainView().contentStackView.addArrangedSubview(lessonScheduleVC.view)
    }
    
    func setupNavbarButtons(){
        let menuButton = UIBarButtonItem(image: .menu, style: .done, target: self, action: #selector(menuAction))
        let alertButton = UIBarButtonItem(image: .bell, style: .done, target: self, action: #selector(alertAction))
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItem = alertButton
    }
}
