//
//  SceneDelegate.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 03/12/23.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        setupNavbar()
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start(DependencyContainer.shared)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func setupNavbar(){
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        
        // MARK: Navigation bar appearance
        let navigationBarAppearanceStandart = UINavigationBarAppearance()
        navigationBarAppearanceStandart.configureWithOpaqueBackground()
        navigationBarAppearanceStandart.backgroundColor = .lightGray
        navigationBarAppearanceStandart.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let navigationBarCompactAppearance = UINavigationBarAppearance()
        navigationBarCompactAppearance.configureWithOpaqueBackground()
        navigationBarCompactAppearance.backgroundColor = .clear
        navigationBarCompactAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.inter(font: .medium, size: 10)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.inter(font: .medium, size: 10)], for: .selected)
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearanceStandart
        UINavigationBar.appearance().compactAppearance = navigationBarCompactAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarCompactAppearance
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

