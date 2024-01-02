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
    private var timer: Timer?
    private var attempts = 3
    private var seconds = 60
    private var canRepeat = true
    
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
        bindLoadingButton()
        resendOtp()
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
    
    private func bindLoadingButton(){
        viewModel.loading
            .drive(onNext: {[weak self] loading in
                self?.mainView().nextButton.startAnimating(loading)
            })
            .disposed(by: bag)
    }
    
    private func resendOtp() {
        mainView().retryStackView.addTapGesture(tapNumber: 1, target: self, action: #selector(sendOtp))
    }

    @objc private func sendOtp() {
        guard attempts != 0 else { return }
        
        if canRepeat {
            mainView().timeContainerStackView.isHidden = false
            mainView().retryStackView.isHidden = true
            viewModel.resendOtp()
                .subscribe()
                .disposed(by: bag)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(decrementSeconds),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    @objc private func decrementSeconds(){
        canRepeat = false
        seconds -= 1
        mainView().timeLabel.text = "0:\(seconds)"
        if seconds == 0 {
            attempts -= 1
            timer?.invalidate()
            mainView().timeContainerStackView.isHidden = true
            mainView().retryStackView.isHidden = false
            mainView().attemtLabel.text = "Осталось \(attempts) попытки"
            canRepeat = true
        }
    }

    
    private func bindNextAction(){
        mainView().nextButton
            .rx
            .controlEvent(.touchUpInside)
            .flatMap({ [unowned self] in
                viewModel.confirmOtp()
            })
            .asDriver(onErrorJustReturn: .error(globalDefaultError))
            .drive(onNext: { result in
                switch result {
                case .success:
                    break
                case .error(let error):
                    if let message = error.message {
                        TopAlertView.shared.showAlert(title: message)
                    }
                    self.fillLabelsError()
                }
            })
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
    
    private func fillLabelsError(){
        let labels = mainView().otpContainerView.arrangedSubviews
            .compactMap { $0 as? OtpNumberView }

        labels.forEach({ $0.borderColor = .Error._300})
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
                label.borderColor = .Main._400
            } else {
                // Clear the label if there is no corresponding character
                label.label.text = "0"
                label.label.textColor = .Gray._200
                label.borderColor = .Gray._300
            }
        }
    }


    
}
