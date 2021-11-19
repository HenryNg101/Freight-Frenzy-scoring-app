//
//  RegisterViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamID: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var imageViewTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var sucess_notification: UILabel!
    
    struct TeamInfo: Equatable {    //Allow different TeamInfo struct objects to be compared
        var teamName: String
        var teamID: Int
        var location: String
        var imageView: UIImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teamName.delegate = self
        teamID.delegate = self
        location.delegate = self
        
        //Add tap gesture and allow user interaction with image, with this tap gesture I can tap image to do actions, and a border to know where to upload image.
        imageView.addGestureRecognizer(imageViewTapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 1
    }
    
    //End editing when touch Return key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    //End the editing when touch anywhere but not the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Open camera roll when touch the tap gesture on the image
    @IBAction func OpenCameraRoll(_ sender: UITapGestureRecognizer) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) && ((sender.view as? UIImageView) != nil) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    @IBAction func AddTeamInfo(_ sender: UIButton) {
        let addedteamName = teamName.text
        let addedteamID = Int(teamID.text ?? "0")
        let addedlocation = location.text
        let addedimage: UIImage = imageView.image ?? UIImage(imageLiteralResourceName: "upload_image.png")
        DataManager.shared.one_team_info.teamName = addedteamName ?? ""
        DataManager.shared.one_team_info.teamID = addedteamID ?? 0
        DataManager.shared.one_team_info.location = addedlocation ?? ""
        DataManager.shared.one_team_info.imageView = addedimage
        sucess_notification.text = "Successfully registered"
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
