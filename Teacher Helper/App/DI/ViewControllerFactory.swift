//
//  ViewControllerFactory.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 08/12/23.
//

import Foundation

protocol ViewControllerFactory {
    func loginVC() -> LoginVC
    func registerVC() -> RegisterVC
    func otpVC(userName: String) -> OtpVC
    func forgotPasswordVC() -> ForgotPasswordVC
    func changePasswordVC() -> ChangePasswordVC
}
