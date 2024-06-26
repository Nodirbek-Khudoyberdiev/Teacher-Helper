//
//  Array + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 22/02/24.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
    
}
