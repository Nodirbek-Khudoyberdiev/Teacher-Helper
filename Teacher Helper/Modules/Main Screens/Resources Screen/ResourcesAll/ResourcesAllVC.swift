//
//  ResourcesAllVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class ResourcesAllVC: BaseViewController<ResourceAllView> {
    
    let didSelectSubject = PublishSubject<ResourcesAllVM>()
    
    private var resourcesAllVM: [ResourcesAllVM] = []
    
    let viewModel: ResourcesAllViewModelProtocol
    
    init(viewModel: ResourcesAllViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindResources()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }

    
    private func bindResources(){
        viewModel.resources
            .observeOnMain()
            .do(onNext: { _ in
                self.mainView().activityIndicator.stopAnimating()
            })
            .bind(to: mainView().rx.items(cellIdentifier: ResourceAllCell.reuseID, cellType: ResourceAllCell.self)) { (_, item,cell) in
                cell.setup(with: item)
            }
            .disposed(by: bag)
        
        mainView().rx.modelSelected(ResourcesAllVM.self)
            .bind(to: didSelectSubject)
            .disposed(by: bag)
        
    }
    
}

