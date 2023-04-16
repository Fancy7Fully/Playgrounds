//
//  ChildVCLandingViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 3/15/23.
//

import Foundation
import UIKit

class ChildVCLandingViewController: UIViewController {
  var stackView: UIStackView = UIStackView()
  var sideMenuButton: UIButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    
    sideMenuButton.setTitle("Open side menu", for: [])
    sideMenuButton.setTitleColor(.black, for: [])
    sideMenuButton.addTarget(self, action: #selector(didTapSideMenuButton), for: .primaryActionTriggered)
    stackView.addArrangedSubview(sideMenuButton)
    
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
    ])
    
    view.backgroundColor = .white
  }
  
  @objc private func didTapSideMenuButton() {
    
  }
}
