//
//  PasswordChangedVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import UIKit

class PasswordChangedVC: BaseViewController<PasswordChangedView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView().loginButton.addTarget(self, action: #selector(openLogin), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    @objc func openLogin(){
        navigationController?.popToViewController(ofClass: LoginVC.self)
    }
}
