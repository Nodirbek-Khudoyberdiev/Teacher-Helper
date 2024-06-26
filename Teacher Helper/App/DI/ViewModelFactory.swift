//
//  ViewModelFactory.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 08/12/23.
//

import Foundation

protocol ViewModelFactory {
    func loginViewModel() -> LoginViewModelProtocol
    func registerViewModel() -> RegisterViewModelProtocol
    func otpViewModel(userName: String) -> OtpViewModelProtocol
    func forgotPasswordViewModel() -> ForgotPasswordViewModelProtocol
    func changePasswordViewModel() -> ChangePasswordViewModelProtocol
    func resourcesAllViewModel() -> ResourcesAllViewModelProtocol
}
