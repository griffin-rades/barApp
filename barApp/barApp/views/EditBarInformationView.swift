//
//  EditBarInformationView.swift
//  barApp
//
//  Created by Griffin Rades on 11/21/19.
//  Copyright © 2019 GriffinRades. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EditBarInformationView: UIViewController{
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var drinkTextField: UITextView!
    @IBOutlet weak var musicTextField: UITextView!
    @IBOutlet weak var barNameText: UITextField!
    
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.welcomeLabel.text = "Welcome: " + (user?.displayName)!
        getData()
    }
    
    func getData(){
        ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let drinks = value?["drinkSpecials"] as? String ?? ""
            let music = value?["music"] as? String ?? ""
            let barName = value?["barName"] as? String ?? ""
            
            self.drinkTextField.text = drinks
            self.musicTextField.text = music
            self.barNameText.text = barName
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    @IBAction func saveClicked(_ sender: Any) {
        self.ref.child("users").child(user!.uid).setValue(["drinkSpecials": drinkTextField.text, "music": musicTextField.text, "barName": barNameText.text])
        self.ref.child("barNames").child(barNameText.text!).setValue(barNameText.text)
    }
}
