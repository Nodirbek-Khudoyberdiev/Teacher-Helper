//
//  ChangePasswordVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class ChangePasswordVC: BaseViewController<ChangePasswordView> {
    
    
    let viewModel: ChangePasswordViewModelProtocol
    
    init(viewModel: ChangePasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButton()
        bindPassword()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    private func bindButton(){
        viewModel.buttonEnabled
            .bind(to: mainView().mainButton.rx.isEnabled)
            .disposed(by: bag)
        
        mainView().mainButton
            .rx
            .controlEvent(.touchUpInside)
            .flatMap({ [unowned self] in
                viewModel.changePassword()
            })
            .subscribe()
            .disposed(by: bag)
        
        viewModel.loading
            .drive(onNext: { loading in
                self.mainView().mainButton.startAnimating(loading)
            })
            .disposed(by: bag)
        
    }
    
    private func bindPassword(){
        mainView().passwordTextField
            .textField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: bag)
    }
    
}
