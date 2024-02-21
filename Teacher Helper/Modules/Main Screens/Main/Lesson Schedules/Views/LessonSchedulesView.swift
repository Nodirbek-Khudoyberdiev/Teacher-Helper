//
//  LessonSchedulesView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

final class LessonSchedulesView: UICollectionView {
  
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

