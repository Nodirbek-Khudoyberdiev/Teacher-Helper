//
//  BaseViewController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import UIKit
import RxSwift

class BaseViewController<RootView: UIView>: UIViewController, ViewSpecificController {
    
    typealias RootView = RootView
    
    let bag = DisposeBag()
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
