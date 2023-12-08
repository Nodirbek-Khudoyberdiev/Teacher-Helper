//
//  ViewSpecificController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

protocol ViewSpecificController: AnyObject {
    associatedtype RootView: UIView
}

extension ViewSpecificController where Self: UIViewController {
    
    @discardableResult
    func mainView() -> RootView {
        guard let rootView = view as? RootView else {
            view = RootView()
            return mainView()
        }
        return rootView
    }
    
}
