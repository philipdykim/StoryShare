//
//  StoryPageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 7/10/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class StoryPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var postid = [String]()
    var indexdata = Int()
    
    lazy var viewControllerList: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let story1 = sb.instantiateViewController(withIdentifier: "firstpage")
        let story2 = sb.instantiateViewController(withIdentifier: "secondpage")
        let story3 = sb.instantiateViewController(withIdentifier: "thirdpage")
        let story4 = sb.instantiateViewController(withIdentifier: "fourthpage")
        
        return [story1, story2, story3, story4]
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstviewcontroller = viewControllerList.first {
            self.setViewControllers([firstviewcontroller], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
