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
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    view.backgroundColor = .white
    view.addSubview(button)
    view.addSubview(button2)
    button.setTitle("Move", for: .normal)
    button.backgroundColor = .blue
    button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    
    button2.setTitle("Waterfall", for: .normal)
    button2.backgroundColor = .blue
    button2.addTarget(self, action: #selector(waterfall), for: .touchUpInside)
  }
  
  @objc func tap() {
    let vc = RearrangableListViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func waterfall() {
    let vc = WaterfallController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
    button2.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
  }
}
