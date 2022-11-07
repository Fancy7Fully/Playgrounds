//
//  PresentationTransitionDelegate.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 11/6/22.
//

import Foundation
import UIKit

class PresentationTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return PresentationController(presentedViewController: presented, presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return nil
  }
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return DismissalTransitionAnimation()
  }
}

class DismissalTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return TimeInterval(2.0)
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
      transitionContext.containerView.alpha = 0.0
    } completion: { completed in
      transitionContext.completeTransition(completed)
    }
  }
}

class PresentationController: UIPresentationController {
  
  override func presentationTransitionWillBegin() {
    guard let containerView = containerView,
          let presentedView = presentedView
    else {
      return
    }
    
    containerView.addSubview(presentedView)
    containerView.backgroundColor = .white
    presentedView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      presentedView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      presentedView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      presentedView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
      presentedView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8)
    ])
    
    let transitionCoordinator = presentingViewController.transitionCoordinator
    
    containerView.alpha = 0.0
    containerView.backgroundColor = .gray
    transitionCoordinator?.animate(alongsideTransition: { context in
      containerView.alpha = 1.0
    })
  }
  
//  override func dismissalTransitionWillBegin() {
//    guard let containerView = containerView else { return }
//    containerView.alpha = 1.0
//    let transitionCoordinator = presentingViewController.transitionCoordinator
//    transitionCoordinator?.animate(alongsideTransition: { context in
//      containerView.alpha = 0.0
//    })
//  }
}
