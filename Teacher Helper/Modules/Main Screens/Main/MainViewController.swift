//
//  MainViewController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView> {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavbarButtons()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    // MARK: Actions
    
    @objc private func menuAction(){
        
    }
    
    @objc private func alertAction(){
        
    }
    
}

// MARK: Setup

extension MainViewController {
    
    private func setup(){
        title = "Teacher Assistant"
    }
    
    private func setupNavbarButtons(){
        let menuButton = UIBarButtonItem(image: .menu, style: .done, target: self, action: #selector(menuAction))
        let alertButton = UIBarButtonItem(image: .bell, style: .done, target: self, action: #selector(alertAction))
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItem = alertButton
    }
}
