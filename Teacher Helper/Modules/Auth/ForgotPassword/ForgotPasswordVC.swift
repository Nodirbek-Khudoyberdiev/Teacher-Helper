//
//  ForgotPasswordVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 02/01/24.
//

import UIKit
import RxCocoa
import RxSwift

class ForgotPasswordVC: BaseViewController<ForgotPasswordView> {
    
    let viewModel: ForgotPasswordViewModelProtocol
    
    init(viewModel: ForgotPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView().phoneTextField.textField.becomeFirstResponder()
    }
    
    private func setup(){
        
        viewModel.buttonEnabled
            .bind(to: mainView().mainButton.rx.isEnabled)
            .disposed(by: bag)
        
        mainView().phoneTextField.textField
            .rx
            .text
            .orEmpty
            .map({$0.digits})
            .bind(to: viewModel.username)
            .disposed(by: bag)
        
        mainView().mainButton
            .rx
            .controlEvent(.touchUpInside)
            .flatMap({ [unowned self] in
                viewModel.sendOtp()
            })
            .subscribe(onNext: { result in
                switch result {
                case .error(let error):
                    TopAlertView.shared.showAlert(title: error.message ?? .localized(.wrongPinOrUsername))
                case .success:
                    TopAlertView.shared.hideAlert()
                }
            })
            .disposed(by: bag)
        
        viewModel.loading
            .drive(onNext: {[weak self] loading in
                self?.mainView().mainButton.startAnimating(loading)
            })
            .disposed(by: bag)
        
    }
    
}
