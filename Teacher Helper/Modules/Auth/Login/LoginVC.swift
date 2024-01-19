//
//  LoginVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class LoginVC: BaseViewController<LoginView> {
    
    var viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoginButton()
        bindFields()
        bindButton()
        bindButtonLoading()
        openRegister()
        openForgotPassword()
    }
    
    override func loadView() {
        super.loadView()
        view = LoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView().firstField.textField.becomeFirstResponder()
    }
    
    private func bindLoginButton(){
        mainView().nextButton
            .rx
            .controlEvent(.touchUpInside)
            .flatMap({ self.viewModel.login()})
            .subscribe(onNext: { result in
                switch result {
                case .error:
                    TopAlertView.shared.showAlert(title: .localized(.wrongPinOrUsername))
                case .success:
                    TopAlertView.shared.hideAlert()
                }
            })
            .disposed(by: bag)
    }
    
    private func openRegister(){
        mainView().subtitleLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .map( { _ in () } )
            .bind(to: viewModel.openRegister)
            .disposed(by: bag)
    }
    
    private func openForgotPassword(){
        mainView().forgotPassword
            .rx
            .controlEvent(.touchUpInside)
            .bind(to: viewModel.openForgotPassword)
            .disposed(by: bag)
    }
    
    private func bindFields(){
        mainView().firstField.textField
            .rx
            .text
            .orEmpty
            .map({$0.digits})
            .bind(to: viewModel.username)
            .disposed(by: bag)
        
        mainView().secondField.textField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: bag)
    }
    
    private func bindButtonLoading(){
        viewModel.loading
            .drive(onNext: {[weak self] loading in
                self?.mainView().nextButton.startAnimating(loading)
            })
            .disposed(by: bag)
    }
    
    private func bindButton(){
        viewModel.buttonEnabled
            .bind(to: mainView().nextButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
}
