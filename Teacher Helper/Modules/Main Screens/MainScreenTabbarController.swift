//
//  MainScreenTabbarController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit
import RxCocoa
import RxSwift

class MainScreenTabbarController: UITabBarController {
    
    let bag = DisposeBag()
    var coodinators: [ReactiveCoordinator<Void>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
        configureSelection()
    }
    
    private func setTabs(){
        let resourceCoordinator = ResourcesScreenCoordinator()
        let resourceNavVC = createNav(with: "Ресурсы", image: .resourcesBookOpen, selectedImge: .resourcesBookOpenSelected, vc: resourceCoordinator.vc)
        self.coodinators.append(resourceCoordinator)
        
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .white
        let homeNavVC = createNav(with: "Главная", image: .homeImage, selectedImge: .homeSelectedImage, vc: homeVC)
        
        
        let calendarVC = UIViewController()
        calendarVC.view.backgroundColor = .white
        let calendarNavVC = createNav(with: "Главная", image: .calendarImage, selectedImge: .calendarSelectedImage, vc: calendarVC)
        
        setViewControllers([homeNavVC, resourceNavVC, calendarNavVC], animated: true)
    }
    
    func configureSelection(){
        self.coodinators.forEach({
            $0.start()
                .subscribe()
                .disposed(by: bag)
        })
    }
    
}
