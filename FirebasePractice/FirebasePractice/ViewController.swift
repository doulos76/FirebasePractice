//
//  ViewController.swift
//  FirebasePractice
//
//  Created by dave76 on 01/06/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
  // MARK:- Properties
  
  @IBOutlet weak var dataDisplayLabel: UILabel!
  
  // MARK:- View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    updateLabel()
    updateChild()
  }

  // MARK:- private method
  
  fileprivate func updateLabel() {
    var ref: DatabaseReference!
    ref = Database.database().reference()

    // observeSingleEvent(of: T##DataEventType, with: T##(DataSnapshot) -> Void)
    ref.child("test").observeSingleEvent(of: .value) { (snapshot) in
      let value = snapshot.value as? String

      DispatchQueue.main.async {
        self.dataDisplayLabel.text = value
      }
    }
    
    // observe(T##eventType: DataEventType##DataEventType, with: T##(DataSnapshot) -> Void)
    ref.child("test").observe(.value) { (snapshot) in
      let value = snapshot.value as? String
      
      DispatchQueue.main.async {
        self.dataDisplayLabel.text = value
      }

    }
  }
  
  func updateChild() {
    let ref = Database.database().reference()
    ref.updateChildValues(["test": "Update Hello world!"])
  }

}

