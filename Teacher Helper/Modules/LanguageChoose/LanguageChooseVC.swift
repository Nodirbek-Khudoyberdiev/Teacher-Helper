//
//  LanguageChooseVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 03/12/23.
//

import UIKit
import RxSwift

class LanguageChooseVC: BaseViewController<LaunguageChooseView> {
    
    let languageChoosed = PublishSubject<Void>()
    
    override func loadView() {
        super.loadView()
        view = LaunguageChooseView(delegate: self)
    }

}

extension LanguageChooseVC: LanguagePickedDelegate {
    func didTapLanguage(_ language: Localization) {
        UserDefaults.standard.saveLocaleCode(languageCode: language)
        languageChoosed.onNext(())
    }
}
