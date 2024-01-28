//
//  UICollectionView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<Cell>(for indexPath: IndexPath, type: Cell.Type = Cell.self) -> Cell where Cell: UICollectionViewCell {
        register(Cell.classForCoder(), forCellWithReuseIdentifier: Cell.reuseID)
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as? Cell else {
            fatalError("Error for cell id: \(Cell.reuseID) at \(indexPath))")
        }
        return cell
    }
}
