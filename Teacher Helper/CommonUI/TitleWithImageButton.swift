//
//  TitleWithImageButton.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

class TitleWithImageButton: UIStackView {
    
    private let defaultColor: UIColor = .Gray._400
    
    var completion: (() -> ())?
    
    private lazy var titleActionLabel: UILabel = {
        let label = UILabel(font: .inter(font: .medium, size: 16),
                            color: defaultColor,
                            lines: 1,
                            alignment: .left)
        return label
    }()
    
    private let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        build(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 8, views: [
            titleActionLabel, button
        ])
        addTapGesture(tapNumber: 1, target: self, action: #selector(didTapButton))
    }
    
    convenience init(_ completion: @escaping () -> ()){
        self.init()
        self.completion = completion
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapButton(){
        completion?()
    }
    
    func setImage(_ image: UIImage?) {
        button.setImage(image, for: .normal)
    }
    
    func setTitle(_ text: String?){
        titleActionLabel.text = text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        titleActionLabel.textColor = .Gray._600
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        titleActionLabel.textColor = defaultColor
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        titleActionLabel.textColor = defaultColor
    }
    
}
