//
//  ViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 7/6/22.
//

import UIKit

class ViewController: UIViewController {
  var button: UIButton = UIButton()
  var webViewButton: UIButton = UIButton()
  var sqliteButton = UIButton()
  var presentationButton = UIButton()
  var delegate: UIViewControllerTransitioningDelegate?
  
  var stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    view.backgroundColor = .white
    button.setTitle("CollectionViews", for: .normal)
    button.backgroundColor = .blue
    button.addTarget(self, action: #selector(collectionViews), for: .touchUpInside)
    
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
  
  @objc func collectionViews() {
    let vc = CollectionViewLandingViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func imagePicker() {
    let vc = PhotoPickerLandingViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}
