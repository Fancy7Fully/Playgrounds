//
//  WaterfallController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 7/10/22.
//

import Foundation
import UIKit
import FirebaseAnalytics

class WaterfallController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var model: [Int] = (1..<20).map { sth in return Int.random(in: 100..<300) }
  
  private lazy var collectionView: UICollectionView = {
    var layout = WaterfallCustomLayout(model: model)
    layout.scrollDirection = .vertical
    
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "waterfallCell")
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "waterfallCell", for: indexPath)
    
    cell.backgroundColor = randomColor()
    
    return cell
  }
  
  func randomColor() -> UIColor {
      let red = CGFloat(drand48())
      let green = CGFloat(drand48())
      let blue = CGFloat(drand48())
      return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
}

class WaterfallCustomLayout: UICollectionViewFlowLayout {
  var attributes: [UICollectionViewLayoutAttributes] = []
  
  var model: Array<Int>
  
  var leftHeight: CGFloat = 0
  
  var rightHeight: CGFloat = 0
  
  init(model: Array<Int>) {
    self.model = model
    
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepare() {
    super.prepare()
    
    attributes.removeAll()
    for i in 0..<model.count {
      if let att = self.layoutAttributesForItem(at: IndexPath(row: i, section: 0)) {
        attributes.append(att)
      }
    }
    
    print(attributes)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let att = super.layoutAttributesForItem(at: indexPath) else { return nil }
    
    let width = (UIScreen.main.bounds.width - 40) / 2
    let height = CGFloat(model[indexPath.row])
    
    if leftHeight < rightHeight {
      att.frame = CGRect(x: 18.0, y: leftHeight + 20.0, width: width, height: height)
      leftHeight += height + 4.0
    } else {
      att.frame = CGRect(x: 22 + width, y: rightHeight + 20.0, width: width, height: height)
      rightHeight += height + 4.0
    }
    
    return att
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributes
  }
  
  override var collectionViewContentSize: CGSize {
    let s = super.collectionViewContentSize
    return CGSize(width: s.width, height: max(rightHeight, leftHeight))
  }
}
