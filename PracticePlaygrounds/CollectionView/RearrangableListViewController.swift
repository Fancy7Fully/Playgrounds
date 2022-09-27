//
//  RearrangableListViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 9/26/22.
//

import Foundation
import UIKit

class RearrangableListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
  
  var model = Array(1..<100)
  
  var button = UIButton()
  
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    session.localContext = collectionView
    let dragItem = UIDragItem(itemProvider: NSItemProvider(object: NSString(string: "\(indexPath.row)")))
    dragItem.localObject = model[indexPath.row]
    
    return [dragItem]
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
    cell.contentView.subviews.forEach { $0.removeFromSuperview() }
    let titleLabel = UILabel(frame: .zero)
    titleLabel.text = String(model[indexPath.row])
    titleLabel.textColor = .black
    cell.contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
    ])
    
    cell.layer.cornerRadius = 16.0
    cell.layer.masksToBounds = true
    cell.backgroundColor = .lightGray
    
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
    return collectionView == (session.localDragSession?.localContext as? UICollectionView)
  }
  
  
  
  //UICollectionViewDatasource methods
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      
      return 1
  }


  // custom function to generate a random UIColor
  func randomColor() -> UIColor{
      let red = CGFloat(drand48())
      let green = CGFloat(drand48())
      let blue = CGFloat(drand48())
      return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.count
  }

  
  var label: UILabel = UILabel()
  
  lazy var collectionView: UICollectionView = {
    let layout = CustomLayout()
    layout.sectionInset = .zero
    layout.itemSize = CGSize(width: 320, height: 100)
    layout.minimumInteritemSpacing = 12
    layout.minimumLineSpacing = 1
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "SeparatorKind", withReuseIdentifier: "Separator")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.dragDelegate = self
    collectionView.dropDelegate = self
    
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.addSubview(collectionView)
    view.addSubview(button)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Move", style: .plain, target: self, action: #selector(didTapMove))
  }
  
  @objc func didTapMove() {
    collectionView.performBatchUpdates {
//      collectionView.deleteItems(at: [IndexPath(index: 4)])
//
//      collectionView.insertItems(at: [IndexPath(index: 5)])
      collectionView.moveItem(at: IndexPath(row: 4, section: 0), to: IndexPath(row: 6, section: 0))
    } completion: { [weak self] success in
      guard let self = self else { return }
      self.collectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    let location = session.location(in: collectionView)
    var correctedIndexPath: IndexPath? = destinationIndexPath
    collectionView.performUsingPresentationValues {
      correctedIndexPath = collectionView.indexPathForItem(at: location)
    }
    
    guard let destinationRow = correctedIndexPath?.row,
          destinationRow < model.count else {
            return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
          }
    
    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    guard let item = coordinator.items.first,
          let oldPath = item.sourceIndexPath,
          let newPath = coordinator.destinationIndexPath,
          newPath.row < model.count else { return }
    
    collectionView.performBatchUpdates {
      collectionView.reloadData()
    }
//    collectionView.reloadData()
    coordinator.drop(item.dragItem, toItemAt: newPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let separator = [collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Separator", for: indexPath)].first!
    
    if kind == "SeparatorKind" {
      separator.backgroundColor = .clear
       
      if separator.subviews.count == 0 {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        separator.addSubview(line)
        
        NSLayoutConstraint.activate([
          line.heightAnchor.constraint(equalToConstant: 12),
          line.leadingAnchor.constraint(equalTo: separator.leadingAnchor, constant: 20),
          line.trailingAnchor.constraint(equalTo: separator.trailingAnchor, constant: -20),
          line.centerYAnchor.constraint(equalTo: separator.centerYAnchor),
        ])
      }
    }
    
    return separator
  }
}

class CustomLayout: UICollectionViewFlowLayout {
  
  override var collectionViewContentSize: CGSize {
    var s = super.collectionViewContentSize
    return CGSize(width: s.width, height: s.height + 64)
    
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
    
    var separatorAttributes: UICollectionViewLayoutAttributes? = nil
    
    for attr in attributes {
      if attr.indexPath.row == 1 {
        separatorAttributes = self.layoutAttributesForSupplementaryView(ofKind: "SeparatorKind", at: attr.indexPath)
        var frame = attr.frame
        frame.size.height = 64
        separatorAttributes?.frame = frame
      }
      
      attr.frame = self.adjustFrameForAttribute(attr)
    }
    
    if let separatorAtt = separatorAttributes {
      var array = attributes
      array.append(separatorAtt)
      return array
    }
    
    return attributes
  }
  
  override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    var attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    if attributes == nil {
      attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
    }
    
    return attributes
  }
  
//  - (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//  {
//      UICollectionViewLayoutAttributes *a = [[super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath] copy];
//
//      if (!a) {
//      // If superview didn’t return anything, we generate our own attributes.
//          a = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
//      }
//
//      return a;
//  }
  
  func adjustFrameForAttribute(_ attr: UICollectionViewLayoutAttributes) -> CGRect {
    var frame = attr.frame
    if attr.indexPath.row > 0 {
      frame.origin.y += 64
    }
    
    return frame
  }
}
