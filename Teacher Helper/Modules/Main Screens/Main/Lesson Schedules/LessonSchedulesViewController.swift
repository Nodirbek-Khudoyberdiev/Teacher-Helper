//
//  LessonSchedulesViewController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

class LessonSchedulesViewController: BaseViewController<UIView> {
    
    private let lessonScheduleView = LessonSchedulesView()
    private let header = LessonScheduleHeaderView()
    
    private var dates: [String] = [
        "Четверг, 16 Ноября",
        "Пятница, 17 Ноября"
    ]
    
    private let vm: [[LessonDetailVM]] = [
        [.init(lessonOrder: 1, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 2, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 3, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 4, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 5, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 6, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 7, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б")],
        
        [.init(lessonOrder: 1, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 2, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 3, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 4, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 1, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 2, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 3, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
         .init(lessonOrder: 4, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б")
        ]
    ]
    
    enum LessonSchedulesConstants {
        static let headerHeight: CGFloat = 40
        static let itemHeight: CGFloat = 56
        static let offset: CGFloat = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureView()
    }
    
}

extension LessonSchedulesViewController: LessonScheduleHeaderDelegate {
    
    func didTapLeftAction() {
        guard let visibleIndexPath = getCurrentVisibleIndexPath(), vm[safe: visibleIndexPath.row - 1] != nil else { return }
        let nextIndex = IndexPath(row: visibleIndexPath.row - 1, section: 0)
        scrollToDestination(nextIndex)
    }
    
    func didTapRightAction() {
        guard let visibleIndexPath = getCurrentVisibleIndexPath(), vm[safe: visibleIndexPath.row + 1] != nil else { return }
        let nextIndex = IndexPath(row: visibleIndexPath.row + 1, section: 0)
        scrollToDestination(nextIndex)
    }
    
    private func scrollToDestination(_ indexPath: IndexPath){
        DispatchQueue.main.async {
            self.lessonScheduleView.isPagingEnabled = false
            self.lessonScheduleView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.lessonScheduleView.isPagingEnabled = true
            self.checkButtons(indexPath.row)
            self.header.date = self.dates[indexPath.row]
        }
    }
    
    private func checkButtons(_ index: Int){
        header.rightActionEnabled = vm[safe: index + 1] != nil
        header.leftActionEnabled = vm[safe: index - 1] != nil
    }
    
}

// MARK: Private

private extension LessonSchedulesViewController {
    
    func setup(){
        lessonScheduleView.delegate = self
        lessonScheduleView.dataSource = self
        header.delegate = self
    }
    
    func configureView(){
        view.addSubviews(header, lessonScheduleView)
        header.date = dates.first ?? ""
        let totalHeight = calculateHeight(for: 0)
        
        view.snp.makeConstraints({
            $0.height.equalTo(totalHeight)
        })
        
        header.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(LessonSchedulesConstants.headerHeight)
        })
        
        lessonScheduleView.snp.makeConstraints({
            $0.top.equalTo(header.snp.bottom).offset(LessonSchedulesConstants.offset)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    func calculateHeight(for index: Int) -> CGFloat {
        return CGFloat((Int(LessonSchedulesConstants.itemHeight) * (vm[safe: index]?.count ?? 0)) + Int(LessonSchedulesConstants.headerHeight + LessonSchedulesConstants.offset))
    }
    
    func getCurrentVisibleIndexPath() -> IndexPath? {
        let visibleRect = CGRect(origin: lessonScheduleView.contentOffset, size: lessonScheduleView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        return lessonScheduleView.indexPathForItem(at: visiblePoint)
    }
}

// MARK: UICollectionViewDataSource

extension LessonSchedulesViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LessonDetailCollectionCell = collectionView.dequeueCell(for: indexPath)
        cell.viewModels = vm[indexPath.item]
        checkButtons(indexPath.row)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension LessonSchedulesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let visibleIndexPath = getCurrentVisibleIndexPath() else { return }
        header.date = dates[visibleIndexPath.item]
        checkButtons(visibleIndexPath.row)
    }
    
}
