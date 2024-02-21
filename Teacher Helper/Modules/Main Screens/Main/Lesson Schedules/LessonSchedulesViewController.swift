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
    
    private let vm: [LessonDetailVM] = [
        .init(lessonOrder: 1, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 2, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 3, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 4, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 5, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 6, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 7, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б"),
        .init(lessonOrder: 8, lessonStartDate: "9.30", lessonEndDate: "10.30", lessonName: "Алгебра", lessonTheme: "Множества", className: "5Б")
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

// MARK: Private

private extension LessonSchedulesViewController {
    
    func setup(){
        lessonScheduleView.delegate = self
        lessonScheduleView.dataSource = self
    }
    
    func configureView(){
        view.addSubviews(header, lessonScheduleView)
        
        let totalHeight = calculateHeight()
        
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
    
    func calculateHeight() -> CGFloat {
        return CGFloat((Int(LessonSchedulesConstants.itemHeight) * (vm.count)) + Int(LessonSchedulesConstants.headerHeight + LessonSchedulesConstants.offset))
    }
    
}

// MARK: UICollectionViewDataSource

extension LessonSchedulesViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LessonDetailCollectionCell = collectionView.dequeueCell(for: indexPath)
        cell.viewModels = vm
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension LessonSchedulesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
