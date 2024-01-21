//
//  ResourcesScreenVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

class ResourcesScreenVC: BaseViewController<ResourceView> {
    
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
        self.addTabVC(resourceBoughtVC)
        
        let resourcesAllVC = ResourcesAllVC()
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
    
    private func addTabVC(_ vc: UIViewController){
        self.addChild(vc)
        self.didMove(toParent: vc)
    }
    
}
