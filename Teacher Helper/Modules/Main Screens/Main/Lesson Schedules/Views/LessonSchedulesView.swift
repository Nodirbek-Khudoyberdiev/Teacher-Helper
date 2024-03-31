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
        isPagingEnabled = true
        backgroundColor = .clear
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

