//
//  ResourcesAllVC.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 21/01/24.
//

import UIKit
import RxSwift
import RxRelay

class ResourcesAllVC: BaseViewController<ResourceAllView> {
    
    let didSelectSubject = PublishSubject<Void>()
    
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
        setupDelegates()
        bindResources()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView()
    }
    
    private func setupDelegates(){
        mainView().delegate = self
        mainView().dataSource = self
    }
    
    private func bindResources(){
        viewModel.resources
            .observeOnMain()
            .subscribe(onNext: {[weak self] resources in
                self?.resourcesAllVM = resources
                self?.mainView().activityIndicator.stopAnimating()
                self?.mainView().reloadData()
            })
            .disposed(by: bag)
    }
    
}

extension ResourcesAllVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourcesAllVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResourceAllCell = tableView.dequeueCell(for: indexPath)
        cell.setup(with: resourcesAllVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectSubject.onNext(())
    }
    
}
