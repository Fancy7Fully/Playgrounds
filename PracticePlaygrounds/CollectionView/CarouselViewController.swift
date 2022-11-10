//
//  CarouselViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhiyuan Zhou on 11/7/22.
//

import Foundation
import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = .zero
    layout.scrollDirection = .horizontal
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isPagingEnabled = true
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCell")
    
    return collectionView
  }()
  
  
}
