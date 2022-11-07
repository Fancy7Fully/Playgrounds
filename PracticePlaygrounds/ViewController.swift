//
//  ViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 7/6/22.
//

import UIKit

class ViewController: UIViewController {
  var button: UIButton = UIButton()
  var button2: UIButton = UIButton()
  var button3: UIButton = UIButton()
  var webViewButton: UIButton = UIButton()
  var sqliteButton = UIButton()
  var presentationButton = UIButton()
  var delegate: UIViewControllerTransitioningDelegate?
  
  var stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    view.backgroundColor = .white
    button.setTitle("Move", for: .normal)
    button.backgroundColor = .blue
    button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    
    button2.setTitle("Waterfall", for: .normal)
    button2.backgroundColor = .blue
    button2.addTarget(self, action: #selector(waterfall), for: .touchUpInside)
    
    button3.setTitle("Photo picker", for: [])
    button3.backgroundColor = .blue
    button3.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
    
    webViewButton.setTitle("Webview", for: [])
    webViewButton.backgroundColor = .blue
    webViewButton.addTarget(self, action: #selector(didTapWebview), for: .touchUpInside)
    
    sqliteButton.setTitle("SQLite", for: [])
    sqliteButton.backgroundColor = .blue
    sqliteButton.addTarget(self, action: #selector(didTapSQLite), for: .touchUpInside)
    
    presentationButton.setTitle("Presentation", for: [])
    presentationButton.backgroundColor = .blue
    presentationButton.addTarget(self, action: #selector(didTapPresentation), for: .touchUpInside)
    
    stackView.axis = .vertical
    stackView.backgroundColor = .white
    stackView.distribution = .equalSpacing
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(button)
    stackView.addArrangedSubview(button2)
    stackView.addArrangedSubview(button3)
    stackView.addArrangedSubview(webViewButton)
    stackView.addArrangedSubview(sqliteButton)
    stackView.addArrangedSubview(presentationButton)
    
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
    ])
  }
  
  @objc func didTapPresentation() {
    let vc = PresentedViewController()
    vc.modalPresentationStyle = .custom
    delegate = PresentationTransitionDelegate()
    vc.transitioningDelegate = delegate
    self.present(vc, animated: true)
  }
  
  @objc func didTapSQLite() {
    let vc = SQLiteTestViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func didTapWebview() {
    let vc = WebviewViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func tap() {
    let vc = RearrangableListViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func waterfall() {
    let vc = WaterfallController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func imagePicker() {
    let vc = PhotoPickerLandingViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}
