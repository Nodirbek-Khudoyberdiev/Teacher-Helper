//
//  OtpVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import UIKit
import RxSwift
import RxCocoa

class OtpVC: BaseViewController<OtpView> {
    
    let viewModel: OtpViewModelProtocol
    
    init(viewModel: OtpViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
        setupOtp()
        bindNextAction()
        bindOtpNumber()
        bindButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView().otpContainerView.textField.becomeFirstResponder()
    }
    
    override func loadView(){
        super.loadView()
        view = mainView()
    }
    
    private func setup(){
        if viewModel.userName.isPhoneNumber {
            mainView().subtitleLabel.text = "Код отправлен на \(viewModel.userName.format(with: maskedFormatPhone))"
        } else {
            mainView().subtitleLabel.text = "Код отправлен на \(viewModel.userName)"
        }
    }
    
    private func bindNextAction(){
        mainView().nextButton
            .rx
            .controlEvent(.touchUpInside)
            .flatMap({
                self.viewModel.sendOtp()
            })
            .subscribe()
            .disposed(by: bag)
        
    }
    
    private func bindButton(){
        viewModel
            .isButtonEnabled
            .bind(to: mainView().nextButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
    private func bindOtpNumber(){
        mainView().otpContainerView.textField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.otpNumber)
            .disposed(by: bag)
    }
    
    private func setupOtp(){
        mainView().otpContainerView.textField.addTarget(self, action: #selector(editingChanged), for: [.editingChanged, .editingDidBegin])
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        if let text = textField.text, text.count > 6 {
            let oldText = String(text.prefix(6))
            textField.text = oldText
        }
        fillOtherLabels()
    }

    private func fillOtherLabels() {
        guard let text = mainView().otpContainerView.textField.text else {
            return
        }

        let labels = mainView().otpContainerView.arrangedSubviews
            .compactMap { $0 as? OtpNumberView }

        for (index, label) in labels.enumerated() {
            if index < text.count {
                // Get the character at the corresponding index in the text
                let character = text[text.index(text.startIndex, offsetBy: index)]

                // Fill the label with the character and change its text color
                label.label.text = String(character)
                label.label.textColor = .appBlackColor
            } else {
                // Clear the label if there is no corresponding character
                label.label.text = "0"
                label.label.textColor = .Gray._200
            }
        }
    }


    
}
