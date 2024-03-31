//
//  MainResourcesBoughtTableCell.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import UIKit

class MainResourcesBoughtTableCell: UITableViewCell {
    
    enum MainResourcesConstants {
        static let interitemSpacing: CGFloat = 8
    }
    
    
    var vm: [ResourcesBoughtResponse]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = MainResourcesConstants.interitemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        clipsToBounds = false
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
}

extension MainResourcesBoughtTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainResourcesBoughtCollectionCell = collectionView.dequeueCell(for: indexPath)
        cell.vm = vm?[indexPath.item]
        return cell
    }
    
    
}

extension MainResourcesBoughtTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:   IndexPath) -> CGSize {
        return CGSize(width: 120, height: 84)
//        guard vm != nil else {
//            return CGSize(width: 120, height: 84)
//        }
//        let top = vm?.quarter[indexPath.row]
//        let pan = top.maskedPan
//        let formatCardPan = "**" + pan.suffix(4)
//        let name = Utils.formatFullNameAbbreviated(top.payeeAccountName)
//        let widthOfNameLabel: CGFloat = name.widthOfString(usingFont: Font.body3) + 28
//        let widthOfCardLabel: CGFloat = formatCardPan.widthOfString(usingFont: Font.body3) + 28
//        let maximumWidth = max(widthOfNameLabel, widthOfCardLabel)
//        return CGSize(width: maximumWidth, height: 56)
    }
}
