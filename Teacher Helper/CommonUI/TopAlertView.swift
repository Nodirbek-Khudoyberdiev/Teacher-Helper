//
//  TopAlertView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 09/12/23.
//

import UIKit

class TopAlertView: UIView {

    private let animationDuration = 0.4
    
    static let shared = TopAlertView()
    
    private var timer: Timer?
    
    lazy var titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(font: .inter(font: .medium, size: 18), color: .white, lines: 2, alignment: .center)
        return label
    }()
    
    private init() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        super.init(frame: frame)
        setupUI()
        addSwipeGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI(){
        backgroundColor = .systemRed
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
    }
    
    func hideAlert(){
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        UIView.animate(withDuration: animationDuration) {
            self.frame = frame
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()
            self.timer?.invalidate()
        }
    }
    
    func showAlert(title: String, showDuration: Double = 1.5){
        guard let window = UIApplication.shared.windows.filter ({$0.isKeyWindow}).first else { return }
        timer?.invalidate()
        window.addSubview(self)
        titleLabel.text = title
        UIView.animate(withDuration: animationDuration){
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
            self.frame = frame
            self.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer(withTimeInterval: showDuration, repeats: false) { [weak self] timer in
            self?.hideAlert()
        }
    }
    
    private func addSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .up
        self.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture() {
        hideAlert()
    }
    
}
