//
//  MakeNoteViewController.swift
//  FunRun
//
//  Created by DINGKaile on 12/3/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

protocol MakeNoteViewControllerDelegate: class {
    func makeNoteViewController(finishWithNote note: String)
}

class MakeNoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var noteDelegate: MakeNoteViewControllerDelegate?
    
    @IBOutlet weak var noteField: UITextView!
    @IBOutlet weak var menuTable: UITableView!
    
    var notes: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        // Setup textView
        self.noteField.layer.borderWidth = 2.0
        self.noteField.layer.borderColor = UIColor.lightGray.cgColor
        self.noteField.layer.cornerRadius = 2.0
        self.noteField.clipsToBounds = true
        */
        self.menuTable.dataSource = self
        self.menuTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup the keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpTextArea), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownTextArea), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.navigationController?.isNavigationBarHidden = false
        self.noteField.text = self.notes
        self.noteField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Setup the keyboard notification
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.notes = self.noteField.text
        self.noteDelegate?.makeNoteViewController(finishWithNote: self.notes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    /* MARK: - TableView Delegate function */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    func moveUpTextArea(notification: Notification) {
        // Need to calculate keyboard exact size due to Apple suggestions
        /*
        let info = notification.userInfo!
        let keyboardHeight = (info[UIKeyboardFrameBeginUserInfoKey] as? CGRect)?.height
        self.scrollViewBottomConstraint.constant = keyboardHeight!
        DispatchQueue.main.async {
            self.scrollView.scrollRectToVisible(self.noteField.frame, animated: true)
        }
        */
        // self.scrollView.scrollRectToVisible(self.noteField.frame, animated: true)
        /*
         let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight!+self.tabBarHeight, 0.0)
         self.scrollView.contentInset = contentInsets
         self.scrollView.scrollIndicatorInsets = contentInsets
         // Move focus to the active field
         // let visibleFrameHeight = self.scrollView.frame.height - keyboardHeight!
         self.scrollView.scrollRectToVisible(self.noteField.frame, animated: true)
         */
    }
    
    func moveDownTextArea(notification: Notification) {
        //Once keyboard disappears, restore original positions
        // self.scrollViewBottomConstraint.constant = 0.0
        /*
         let zeroContentInsets: UIEdgeInsets = UIEdgeInsets.zero
         self.scrollView.contentInset = zeroContentInsets
         self.scrollView.scrollIndicatorInsets = zeroContentInsets
         */
    }
    

    
    
}
