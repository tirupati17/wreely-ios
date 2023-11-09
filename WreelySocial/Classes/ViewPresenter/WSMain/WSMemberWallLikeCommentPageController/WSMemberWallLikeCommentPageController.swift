//
//  WSMemberWallLikeCommentPageController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

class WSMemberWallLikeCommentPageController: UIPageViewController {
    var segmentControl : UISegmentedControl!
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.memberWallLikeView,
                self.memberWallCommentView]
    }()
    var memberWall : WSMemberWall? {
        didSet {
            self.memberWallLikeView.memberWall = memberWall
            self.memberWallCommentView.memberWall = memberWall
        }
    }
    var isCommentMode : Bool = false
    var memberWallLikeView : WSMemberWallLikeView = {
        let vc = WSMemberWallLikeView()
        return vc
    }()

    var memberWallCommentView : WSMemberWallCommentView = {
        let vc = WSMemberWallCommentView()
        return vc
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
        segmentControl.insertSegment(withTitle: "Likes", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Comments", at: 1, animated: false)
        segmentControl.addTarget(self, action: #selector(self.segmentAction(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = self.isCommentMode ? 1 : 0
        self.navigationItem.titleView = segmentControl
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        segmentAction(segmentControl)
    }
    
    func removeSwipeGesture(){
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    @objc func segmentAction(_ segmentAction : UISegmentedControl) {
        if segmentAction.selectedSegmentIndex == 0 {
            self.setViewControllers([self.orderedViewControllers[0]], direction: .reverse, animated: false, completion: nil)
        } else if segmentAction.selectedSegmentIndex == 1 {
            self.setViewControllers([self.orderedViewControllers[1]], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension WSMemberWallLikeCommentPageController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !(completed) {
            return
        }
        self.segmentControl.selectedSegmentIndex = pageViewController.viewControllers!.first!.view.tag //Page Index
    }
}

extension WSMemberWallLikeCommentPageController: UIPageViewControllerDataSource {
    
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
