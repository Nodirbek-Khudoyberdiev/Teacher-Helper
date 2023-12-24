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
    private var attempts = 3
    
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
        let getCodeTapObservable = mainView().getCodeLabel.rx.tapGesture().when(.recognized)
        let retryTapObservable = mainView().retryImageView.rx.tapGesture().when(.recognized)

        Observable.combineLatest(getCodeTapObservable, retryTapObservable)
            .flatMap { [unowned self] _ -> Observable<Int> in
                // Disable UI elements here if needed
                return countdownTimer()
            }
            .flatMap { [unowned self] remainingSeconds -> Observable<Void> in
                // Update UI with remaining time
                updateTimerLabel(remainingSeconds)
                return viewModel.resendOtp()
            }
            .subscribe()
            .disposed(by: bag)
    }

    private func countdownTimer() -> Observable<Int> {
        attempts = 1 // Reset attempts if needed
        mainView().retryStackView.isHidden = true
        mainView().timeContainerStackView.isHidden = false
        var seconds = 60 // Initial countdown time

        return Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(while: { [unowned self] _ in
                if seconds > 0 {
                    seconds -= 1
                }
                return seconds > 0 && self.attempts > 0
            })
            .do(onCompleted: { [unowned self] in
                // Show retryStackView and hide timeContainerStackView when countdown completes
                self.mainView().retryStackView.isHidden = false
                self.mainView().timeContainerStackView.isHidden = true
            })
            .map { _ in
                // Emit remaining seconds
                return seconds
            }
    }


    private func updateTimerLabel(_ seconds: Int) {
        mainView().timeLabel.text = "0:\(seconds)"
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
