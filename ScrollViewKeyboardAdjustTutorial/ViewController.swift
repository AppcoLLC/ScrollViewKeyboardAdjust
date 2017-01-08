//
//  ViewController.swift
//  UIScrollViewIBTutorial
//
//  Created by Michael Oudenhoven on 12/24/16.
//  Copyright © 2016 Appco LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var keyboardVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //add observers to call methods when the keyboard appears or dissappears - to adjust scroll view
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //print("view did disappear rebar")
        
        //remove observers when view is destroyed
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Observer Methods
    
    //method to make scroll view function when the keyboard appears
    func keyboardWillShow(_ notification: Notification) {
        //print("keyboard will show rebar")
        
        if !keyboardVisible {
            //get the size of the keyboard and add it to the scroll view height so that the user can access all fields and buttons
            //            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            //                //print("updating constraints")
            //                //print(keyboardSize.height)
            //                //add only half the keyboard height, otherwise scroll view can scroll farther than necessary
            //                //scrollViewHeightConstraint.constant += keyboardSize.height/2
            //            }
            
            //move to text field into view - http://stackoverflow.com/questions/28813339/move-a-view-up-only-when-the-keyboard-covers-an-input-field
            //Need to calculate keyboard exact size due to Apple suggestions
            self.scrollView.isScrollEnabled = true
            let info : NSDictionary = notification.userInfo! as NSDictionary
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
            let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize!.height-30), 0.0)
            
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect : CGRect = self.view.frame
            aRect.size.height -= keyboardSize!.height
//            if activeTextField != nil
//            {
//                if (!aRect.contains(activeTextField!.frame.origin))
//                {
//                    self.scrollView.scrollRectToVisible(activeTextField!.frame, animated: true)
//                }
//            }
            
            //keyboard is now visible
            keyboardVisible = true
            
            
        }
        
        
        
    }
    
    func keyboardWillHide(_ notification : Notification) {
        //print("keyboard will hide")
        
        if keyboardVisible {
            //keyboard hiding set scroll view back to regular height
            //self.scrollViewHeightConstraint.constant = self.defaultScrollViewHeightConstraint
            
            //Once keyboard disappears, restore original positions
            //let info : NSDictionary = notification.userInfo!
            //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
            //let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
            let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            //self.view.endEditing(true)
            //self.scrollView.scrollEnabled = true
            //self.viewWillLayoutSubviews()
            
            //keyboard no longer visible
            keyboardVisible = false
        }
        
        
        
    }
    
    
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }



}

