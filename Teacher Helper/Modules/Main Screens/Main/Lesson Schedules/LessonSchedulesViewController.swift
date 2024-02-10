//
//  LessonSchedulesViewController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

class LessonSchedulesViewController: BaseViewController<LessonSchedulesView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }

}
