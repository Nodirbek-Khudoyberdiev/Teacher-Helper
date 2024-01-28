//
//  UIViewController + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

extension UIViewController {
    
    func addChildVC(_ vc: UIViewController){
        self.addChild(vc)
        self.didMove(toParent: vc)
    }
    
}

