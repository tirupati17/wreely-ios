//
//  WSMemberCompanyPageController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 24/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMemberCompanyPageController: UIPageViewController {
    var segmentControl : UISegmentedControl!
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(identifier: WSMemberWallView.storyboardIdentifier),
                self.newColoredViewController(identifier: WSEventListView.storyboardIdentifier),
                self.newColoredViewController(identifier: WSCompanyListView.storyboardIdentifier),
                self.newColoredViewController(identifier : WSMemberListView.storyboardIdentifier)]
    }()
    
    private func newColoredViewController(identifier: String) -> UIViewController {
        return (self.storyboard?.instantiateViewController(withIdentifier: identifier))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataSource = self
        delegate = self
        self.view.backgroundColor = .white
        removeSwipeGesture()
        
        segmentControl = UISegmentedControl.init()
        segmentControl.tintColor = UIColor.white
        segmentControl.insertSegment(withTitle: "Member Wall", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Events", at: 1, animated: false)
        //segmentControl.insertSegment(withTitle: "Companies", at: 2, animated: false)
        //segmentControl.insertSegment(withTitle: "Members", at: 3, animated: false)
        segmentControl.addTarget(self, action: #selector(self.segmentAction(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        
        self.navigationItem.titleView = segmentControl
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func removeSwipeGesture(){
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    @objc func segmentAction(_ segmentAction : UISegmentedControl) {
        self.setViewControllers([self.orderedViewControllers[segmentAction.selectedSegmentIndex]], direction: .reverse, animated: false, completion: nil)
    }
}

extension WSMemberCompanyPageController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !(completed) {
            return
        }
        self.segmentControl.selectedSegmentIndex = pageViewController.viewControllers!.first!.view.tag //Page Index
    }
}

extension WSMemberCompanyPageController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}


