//
//  CollectionViewLandingViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 11/7/22.
//

import Foundation
import UIKit

class CollectionViewLandingViewController: UIViewController {
  let stackView = UIStackView()
  let waterfallButton = UIButton()
  let rearrangableButton = UIButton()
  let carouselButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    
    waterfallButton.setTitle("waterfall", for: [])
    waterfallButton.setTitleColor(.black, for: [])
    waterfallButton.addTarget(self, action: #selector(didTapWaterfall), for: .touchUpInside)
    
    rearrangableButton.setTitle("rearrangable", for: [])
    rearrangableButton.setTitleColor(.black, for: [])
    rearrangableButton.addTarget(self, action: #selector(didTapRearrange), for: .touchUpInside)
    
    carouselButton.setTitle("carousel", for: [])
    carouselButton.setTitleColor(.black, for: [])
    carouselButton.addTarget(self, action: #selector(didTapCarousel), for: .touchUpInside)
    
    stackView.addArrangedSubview(waterfallButton)
    stackView.addArrangedSubview(rearrangableButton)
    stackView.addArrangedSubview(carouselButton)
    view.addSubview(stackView)
    stackView.frame = view.frame
    view.backgroundColor = .white
  }
  
  @objc private func didTapWaterfall() {
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func didTapRearrange() {
    let vc = RearrangableListViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func didTapCarousel() {
    let vc = CarouselViewController(collectionViewLayout: ZoomAndSnapFlowLayout())
    navigationController?.pushViewController(vc, animated: true)
  }
}
