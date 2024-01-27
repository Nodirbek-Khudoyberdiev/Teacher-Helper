//
//  ResourcesScreenVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit
import RxSwift
import RxRelay

class ResourcesScreenVC: BaseViewController<ResourceView> {
    
    let didSelectSubject = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setControllers(){
        let resourceBoughtVC = ResourceBoughtScreenVC()
        resourceBoughtVC.didSelectSubject
            .bind(to: didSelectSubject)
            .disposed(by: bag)
        
        self.addTabVC(resourceBoughtVC)
        
        let viewModel = DependencyContainer.shared.resourcesAllViewModel()
        let resourcesAllVC = ResourcesAllVC(viewModel: viewModel)
        resourcesAllVC.didSelectSubject
            .bind(to: didSelectSubject)
            .disposed(by: bag)
        
        self.addTabVC(resourcesAllVC)
        
        mainView().viewPager.tabbedView.tabs = [
            AppTabItemView(title: "Купленные"),
            AppTabItemView(title: "Все ресурсы")
        ]
        mainView().viewPager.pagedView.pages = [
            resourceBoughtVC.view,
            resourcesAllVC.view
        ]
    }
    
}
