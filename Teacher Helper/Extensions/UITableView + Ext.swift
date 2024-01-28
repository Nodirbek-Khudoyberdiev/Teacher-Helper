//
//  UITableView + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

extension UITableView {
    
    func dequeueCell<Cell>(for indexPath: IndexPath, type: Cell.Type = Cell.self) -> Cell where Cell: UITableViewCell {
        register(Cell.classForCoder(), forCellReuseIdentifier: Cell.reuseID)
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as? Cell else {
            fatalError("Error for cell id: \(Cell.reuseID) at \(indexPath))")
        }
        return cell
    }

}
