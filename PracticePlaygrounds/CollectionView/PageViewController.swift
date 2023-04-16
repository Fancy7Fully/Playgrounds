//
//  PageViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 4/10/23.
//

import Foundation
import UIKit

class PageChildViewController : UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = randomColor()
  }
  
  func randomColor() -> UIColor {
      let red = CGFloat(drand48())
      let green = CGFloat(drand48())
      let blue = CGFloat(drand48())
      return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
}

class PageViewController : UIPageViewController {
  let model: [UIViewController] = (1..<5).map { idx in
    return PageChildViewController()
  }
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    self.setViewControllers([model.first!], direction: .forward, animated: true)
  }
}

extension PageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let firstIndex = model.firstIndex(of: viewController) else {
      return nil
    }
    
    if firstIndex == 0 {
      return nil
    } else {
      return model[firstIndex - 1]
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let firstIndex = model.firstIndex(of: viewController) else {
      return nil
    }
    
    if firstIndex == model.count - 1 {
      return nil
    } else {
      return model[firstIndex + 1]
    }
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return model.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    if let currentVC = self.viewControllers!.first {
        let currentIndex = model.index(of: currentVC)
        return currentIndex!
    } else {
        return 0
    }
  }
}
