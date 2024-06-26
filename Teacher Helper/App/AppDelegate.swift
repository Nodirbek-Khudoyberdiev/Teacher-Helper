//
//  AppDelegate.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 03/12/23.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let bag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkInternet()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func checkInternet(){
        NetworkChecker.shared.checkInternet
            .distinctUntilChanged()
            .drive(onNext: { internetConnected in
                if let window = UIApplication.shared.windows.filter ({$0.isKeyWindow}).first {
                    if window.subviews.contains(where: { $0 is TopAlertView }) {
                        if internetConnected {
                            TopAlertView.shared.hideAlert()
                        }
                    } else {
                        if !internetConnected {
                            TopAlertView.shared.showAlert(title: .localized(.noInternetConnection), showDuration: Double.infinity)
                        }
                    }
                }
            })
            .disposed(by: bag)

            
        NetworkChecker.shared.monitorNetwork()
    }
}



