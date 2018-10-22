//
//  PhotosViewController.swift
//  SampleHG
//
//  Created by Chandana on 10/18/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotosViewController: UIViewController {
    private let photosViewModel = PhotosViewModel()
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        imageView.image = UIImage(named: Constants.PHOTOS)
        imageView.contentMode = .center
        imageView.alpha = 0.5
    }
    
    func alert() {
        let alertController = UIAlertController(title: photosViewModel.ALERT_TITLE, message: photosViewModel.ALERT_MESSAGE, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: photosViewModel.SETTINGS_TITLE, style: .default) {
            UIAlertAction in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: photosViewModel.CANCEL, style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkPermission() -> PHAuthorizationStatus {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access granted")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status: \(newStatus)")
            })
        case .restricted, .denied:
            alert()
        }
        return photoAuthorizationStatus
    }
    
    @IBAction func didTapUploadButton(_ sender: Any) {
        let status = checkPermission()
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        if status == .authorized {
            self.present(image, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = Constants.PHOTOS
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: Constants.FONT, size: 19)]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes as [NSAttributedString.Key: Any]
    }
}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.alpha = 1
        }
        self.dismiss(animated: true, completion: nil)
    }
}
