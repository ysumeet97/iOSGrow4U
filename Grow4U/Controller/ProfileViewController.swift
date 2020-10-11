//
//  ProfileViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class ProfileViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var preferencesAdd: UIButton!
    
    var profileViewModel: ProfileViewModel?
    var profile_data: (first_name: String, last_name: String, email: String, phone: String, address: String, preferences: [String])?
    var imagePicker = UIImagePickerController()
    var updatedImageUrl :String?
    private var isImageLocal = true
    private let imageName = "profile.jpeg"
    var productPreferences: [String] = []
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        outerScrollView.delegate = self
        self.setImage()
        profile_data = profileViewModel!.getData()
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address, preferences: profile_data!.preferences)
        // initially load all values
        self.productPreferences = profile_data!.preferences
        let saved = getSavedImage(named: self.imageName)
        if (saved != nil) {
            profile_image.image = getSavedImage(named: self.imageName)
        }
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
        self.setDefaultBorderTextField()
        //This will work in devices less than ios 13
        UIApplication.statusBarBackgroundColor = UIColor(red: 21/255, green: 178/255, blue: 65/255, alpha: 1)
        // dismiss keyboard
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setTextFieldBorder(textFieldToSet: UITextField, color: UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textFieldToSet.frame.height+2, width: textFieldToSet.frame.width, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        textFieldToSet.borderStyle = .none
        textFieldToSet.layer.addSublayer(bottomLine)
    }
    
    private func setDefaultBorderTextField() {
        self.setTextFieldBorder(textFieldToSet: firstNameTextField, color: UIColor.white )
        self.setTextFieldBorder(textFieldToSet: lastNameTextField, color: UIColor.white )
        self.setTextFieldBorder(textFieldToSet: addressTextField, color: UIColor.white )
        self.setTextFieldBorder(textFieldToSet: phoneTextField, color: UIColor.white )
        self.setTextFieldBorder(textFieldToSet: emailTextField, color: UIColor.white )
    }
    
    private func setEditBorderTextField() {
        self.setTextFieldBorder(textFieldToSet: firstNameTextField, color: UIColor.lightGray )
        self.setTextFieldBorder(textFieldToSet: lastNameTextField, color: UIColor.lightGray )
        self.setTextFieldBorder(textFieldToSet: addressTextField, color: UIColor.lightGray )
        self.setTextFieldBorder(textFieldToSet: phoneTextField, color: UIColor.lightGray )
        self.setTextFieldBorder(textFieldToSet: emailTextField, color: UIColor.lightGray )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile_data!.preferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.textLabel?.text = profile_data!.preferences[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            profile_data!.preferences.remove(at: indexPath.row)
            productPreferences.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //for inserting into rows
            
        }
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
        preferencesAdd.isHidden = value
    }
    
    private func setTextData(first_name: String, last_name: String, email: String, phone: String, address: String, preferences: [String]) {
        firstNameTextField.text = first_name
        lastNameTextField.text = last_name
        emailTextField.text = email
        phoneTextField.text = phone
        addressTextField.text = address
    }
    
    private func setImage() {
        self.profile_image.contentMode = .scaleAspectFill
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        self.profile_image.clipsToBounds = true
        
        
        let myView = self.editImageButton
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: myView!.frame.size.width / 2, y: -49 ), radius: myView!.frame.size.width/2.25, startAngle: 0.0, endAngle: .pi, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        myView!.layer.mask = circleShape
        myView!.contentMode = .scaleAspectFit
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
        if (outerScrollView.contentSize.height > outerScrollView.bounds.size.height) {
            let bottomOffset = CGPoint(x: 0, y: outerScrollView.contentSize.height - outerScrollView.bounds.size.height)
            outerScrollView.setContentOffset(bottomOffset, animated: true)
        }
        self.setEditBorderTextField()
        self.setTextFieldProperties(value: true)
        self.setButtonProperties(value: false)
    }
    
    @IBAction func saveAction(_ sender: UIButton?) {
        let topOffset = CGPoint(x: 0, y: 0)
        outerScrollView.setContentOffset(topOffset, animated: true)
        let profile_data = ["first_name": self.firstNameTextField.text!,
                            "last_name": self.lastNameTextField.text!,
                            "email": self.emailTextField.text!,
                            "phone": self.phoneTextField.text!,
                            "address": self.addressTextField.text!]
        profileViewModel?.writeJsonFile(profile: profile_data, preferences: productPreferences)
        self.setDefaultBorderTextField()
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
        showAlertButtonTapped(saveButton)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        let topOffset = CGPoint(x: 0, y: 0)
        outerScrollView.setContentOffset(topOffset, animated: true)
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address, preferences: profile_data!.preferences)
        self.setDefaultBorderTextField()
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
    }
    @IBAction func addPreferences(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Preference", message: "Add your preference", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let pref = textField.text else {
                    return
            }
            self.profile_data!.preferences.append(pref)
            //adding new pref to local var
            self.productPreferences.append(pref)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title:"", message: "Profile\nUpdated!", preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: "Profile\nUpdated!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editImage(_ sender: UIButton) {
        super.viewDidLoad()
        var permitted = false
        var alert = UIAlertController(title:"Permission not granted to access media!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        // The user has previously granted access to the camera.
        case .authorized:
            permitted = true
        // The user has not yet been asked for camera access.
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    permitted = granted
                }
            }
        // The user has previously denied access or the user can't grant access due to restrictions.
        default:
            permitted = false
            self.present(alert, animated: true, completion: nil)
        }
        if (permitted) {
            self.editImageButton.setTitleColor(UIColor.white, for: .normal)
            self.editImageButton.isUserInteractionEnabled = true
            
            alert = UIAlertController(title: "Choose Profile Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            //action sheet for ipad
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profile_image.image = image
        }
        
        //if (info[UIImagePickerController.InfoKey.imageURL] as? URL) != nil{
        let imgName = "/" + imageName
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let localPath = documentDirectory?.appending(imgName)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let data = image.pngData()! as NSData
        data.write(toFile: localPath!, atomically: true)
        updatedImageUrl = localPath
        isImageLocal = true
        // }
        dismiss(animated: true, completion: nil)
        //        saveAction(nil)
        showAlertButtonTapped(saveButton)
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


