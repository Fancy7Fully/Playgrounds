//
//  PhotoPickerLandingViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 10/4/22.
//

import Foundation
import UIKit

class PhotoPickerLandingViewController: UIViewController {
  
  private var button: UIButton = UIButton()
  private var picker: UIImagePickerController = UIImagePickerController()
  private var placeholderView: UIImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    configureButton()
  }
  
  private func configureButton() {
    button.setTitle("Pick photo", for: [])
    button.backgroundColor = .blue
    button.setTitleColor(.white, for: [])
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    button.addTarget(self, action: #selector(didTapPicker), for: .touchUpInside)
    view.addSubview(placeholderView)
    placeholderView.translatesAutoresizingMaskIntoConstraints = false
    placeholderView.backgroundColor = .clear
    placeholderView.layer.borderColor = UIColor.cyan.cgColor
    placeholderView.layer.borderWidth = 2.0
    
    NSLayoutConstraint.activate([
      placeholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      placeholderView.heightAnchor.constraint(equalToConstant: 300),
      placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      placeholderView.widthAnchor.constraint(equalToConstant: 300),
      button.topAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant: 30.0),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  @objc private func didTapPicker() {
    picker.delegate = self
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    picker.mediaTypes = ["public.image", "public.movie"]
    
    self.present(picker, animated: true)
  }
}

extension PhotoPickerLandingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }

  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.originalImage] as? UIImage else {
      picker.dismiss(animated: true)
      return
    }
    placeholderView.image = image
    placeholderView.contentMode = .scaleToFill
    picker.dismiss(animated: true)
  }
}
