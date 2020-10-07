//
//  ProfileViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var outerScrollView: UIScrollView!
    @IBOutlet weak var innerScrollView: UIScrollView!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editImageButton: UIButton!
    
    var profileViewModel: ProfileViewModel?
    var profile_data: (first_name: String, last_name: String, email: String, phone: String, address: String, image: String)?
    var imagePicker = UIImagePickerController()
    var updatedImageUrl :String?
    private var isImageLocal = true
    private let imageName = "profile.jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        outerScrollView.delegate = self
        self.setImage()
        profile_data = profileViewModel!.getData()
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address)
        updatedImageUrl = profile_data!.image
        updateImage(from: updatedImageUrl!, imageViewToSet: self.profile_image)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
        UIApplication.statusBarBackgroundColor = UIColor(red: 21/255, green: 178/255, blue: 65/255, alpha: 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    
    private func setTextFieldProperties(value: Bool) {
        self.firstNameTextField.isUserInteractionEnabled = value
        self.lastNameTextField.isUserInteractionEnabled = value
        self.phoneTextField.isUserInteractionEnabled = value
        self.addressTextField.isUserInteractionEnabled = value
        self.emailTextField.isUserInteractionEnabled = value
    }
    
    private func setButtonProperties(value: Bool) {
        saveButton.isHidden = value
        cancelButton.isHidden = value
    }
    
    private func setTextData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        firstNameTextField.text = first_name
        lastNameTextField.text = last_name
        emailTextField.text = email
        phoneTextField.text = phone
        addressTextField.text = address
    }
    
    private func setImage() {
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        self.profile_image.clipsToBounds = true
        
        
        let myView = self.editImageButton
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: myView!.frame.size.width / 2, y: -49 ), radius: myView!.frame.size.width/2.25, startAngle: 0.0, endAngle: .pi, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        myView!.layer.mask = circleShape
    }
    
    private func updateImage(from url: String, imageViewToSet: UIImageView) {
        if !isImageLocal {
            guard let imageURL = URL(string: url) else { return }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    imageViewToSet.image = image
                }
            }
        } else {
            if let image = getSavedImage(named: self.imageName) {
                imageViewToSet.image = image
            }
        }
        
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    public func setProfileModel(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
    
    //MARK: Actions
    @IBAction func editProfileData(_ sender: UIButton) {
        let bottomOffset = CGPoint(x: 0, y: outerScrollView.contentSize.height - outerScrollView.bounds.size.height)
        outerScrollView.setContentOffset(bottomOffset, animated: true)
        self.setTextFieldProperties(value: true)
        self.setButtonProperties(value: false)
    }
    
    @IBAction func saveAction(_ sender: UIButton?) {
        let profile_data = ["first_name": self.firstNameTextField.text!,
                            "last_name": self.lastNameTextField.text!,
                            "email": self.emailTextField.text!,
                            "phone": self.phoneTextField.text!,
                            "address": self.addressTextField.text!,
                            "image": self.updatedImageUrl!]
        profileViewModel?.writeJsonFile(profile: profile_data)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
        showAlertButtonTapped(saveButton)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        let topOffset = CGPoint(x: 0, y: 0)
        outerScrollView.setContentOffset(topOffset, animated: true)
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
    }
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title:"", message: "Profile\nUpdated!", preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: "Profile\nUpdated!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profile_image.image = image
        }
        
        if (info[UIImagePickerController.InfoKey.imageURL] as? URL) != nil{
            let imgName = "/" + imageName
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            updatedImageUrl = localPath
            isImageLocal = true
        }
        dismiss(animated: true, completion: nil)
        saveAction(nil)
    }
}


// custom status bar color
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
