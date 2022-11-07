//
//  PresentedViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 11/6/22.
//

import Foundation
import UIKit

class PresentedViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .red
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: #selector(didTap));
    view.addGestureRecognizer(gesture)
  }
  
  @objc private func didTap() {
    self.presentingViewController?.dismiss(animated: true)
  }
}
