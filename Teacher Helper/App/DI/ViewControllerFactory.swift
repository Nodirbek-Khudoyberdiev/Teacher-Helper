//
//  ViewControllerFactory.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 08/12/23.
//

import Foundation

protocol ViewControllerFactory {
    
    // MARK: Auth VC
    func loginVC() -> LoginVC
    func registerVC() -> RegisterVC
    func otpVC(userName: String) -> OtpVC
    func forgotPasswordVC() -> ForgotPasswordVC
    func changePasswordVC() -> ChangePasswordVC
    
    // MARK: MainScreen VC
    func mainScreen() -> MainScreenTabbarController
    func subjectDetailScreen() -> SubjectDetailVC
    func resourcesScreen() -> ResourcesScreenVC
    func resourceAllVC() -> ResourcesAllVC
}
