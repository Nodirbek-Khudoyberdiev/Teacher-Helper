//
//  BaseProtocol.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

typealias BaseView = SetupView & SetupViewProtocol
typealias BaseHFTabvieView = SetupTableHeaderFooterView & SetupViewProtocol
typealias BaseTableCell = SetupTableCell & SetupViewProtocol
typealias BaseCollectionCell = SetupCollectionCell & SetupViewProtocol
typealias BaseHFCollectionView = SetupCollectionHeaderView & SetupViewProtocol

protocol SetupViewProtocol {
    var touchesEnd: UIColor? { get }
    var touchesBegin: UIColor? { get }
    var isSelectionEnabled: Bool { get }
    func setup()
    func setupConstrains()
}
extension SetupViewProtocol  {
    
    
    var isSelectionEnabled: Bool {
        return false
    }
    
    var touchesEnd: UIColor? {
        return nil
    }
    
    var touchesBegin: UIColor? {
        return nil
    }
}

class SetupTableHeaderFooterView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        guard let view = self as? BaseHFTabvieView else {
            return
        }
        view.setup()
        view.setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

class SetupView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = self as? BaseView else {
            return
        }
        backgroundColor = .white
        view.setup()
        view.setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let view = self as? BaseView else {
            return
        }
        if view.isSelectionEnabled {
            setColor(view.touchesBegin)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let view = self as? BaseView else {
            return
        }
        if view.isSelectionEnabled {
            setColor(view.touchesEnd)
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard let view = self as? BaseView else {
            return
        }
        if view.isSelectionEnabled {
            setColor(view.touchesEnd)
        }
    }
    
    private func setColor(_ color: UIColor?){
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = color
        }
    }
}

class SetupTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        guard let view = self as? BaseTableCell else {
            return
        }
        view.selectionStyle = .none
        view.setup()
        view.setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SetupCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = self as? BaseCollectionCell else {
            return
        }
        view.setup()
        view.setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

class SetupCollectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = self as? BaseHFCollectionView else {
            return
        }
        view.setup()
        view.setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
/*
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let touch = touches.first
     if touch?.view != self.mainView
     {
         dismissSelf()
     }

 }
 */
