//
//  CreatingMealTableViewController.swift
//  EatingJournal
//
//  Created by Laura Calinoiu on 13/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class CreatingMealTableViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var contentTextField: UITextField! {
    didSet{
      contentTextField.delegate = self
      contentTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
    }
  }
  
  @IBOutlet weak var snapImageView: UIImageView!
  @IBOutlet weak var progressBar: UIProgressView!
  private var picker = UIImagePickerController() { didSet {picker.delegate = self} }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentTextField.becomeFirstResponder()
    applyCompletionOnContentTextField()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    applyCompletionOnContentTextField()
    return true
  }
  
  func textFieldDidChange(textField: UITextField){
    applyCompletionOnContentTextField()
  }
  
  private func computeCompletionOnContentTextField() -> Float{
    var completion: Float = 0.0
    if (contentTextField.text ?? "").isEmpty{
      completion = 0.0
    } else {
      completion = ConstantsInCreating.PROGRESS_WITH_CONTENT
    }
    return completion
  }
  
  private func applyCompletionOnContentTextField(){
    progressBar.setProgress(computeCompletionOnContentTextField(), animated: true)
  }
  
  @IBAction func handlingTakingPictures(sender: UIButton) {
    
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
      self.camera()
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
      self.photoLibrary()
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
    
    self.presentViewController(actionSheet, animated: true, completion: nil)
  }
  
  private func camera(){
    picker.allowsEditing = false //2
    picker.sourceType = .Camera //3
    presentViewController(picker, animated: true, completion: nil)
  }
  private func photoLibrary(){
    picker.allowsEditing = false //2
    picker.sourceType = .PhotoLibrary //3
    presentViewController(picker, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
    snapImageView.contentMode = .ScaleAspectFit //3
    snapImageView.image = chosenImage //4
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

struct ConstantsInCreating{
  static let PROGRESS_WITH_CONTENT: Float = 0.5
}