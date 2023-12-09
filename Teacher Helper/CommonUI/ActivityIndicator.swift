//
//  ActivityIndicator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 09/12/23.
//

import UIKit

protocol ActivityIndicatorProtocol where Self: UIView {
    func startAnimating(_ value: Bool)
}

final class ActivityIndicator: UIActivityIndicatorView {
    init(){
        super.init(frame: .zero)
        color = .black
        hidesWhenStopped = true
        style = .medium
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
