//
//  UIViewController + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

extension UIViewController {
    
    func addTabVC(_ vc: UIViewController){
        self.addChild(vc)
        self.didMove(toParent: vc)
    }
    
}

