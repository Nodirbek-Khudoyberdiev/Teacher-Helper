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
        
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
}
