//
//  BarLoginView.swift
//  barApp
//
//  Created by Griffin Rades on 11/21/19.
//  Copyright © 2019 GriffinRades. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI

class BarLoginView: UIViewController{
    var informationLabel = UILabel()
    var loginButton = UIButton()
    var itemDictionary = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemDictionary["label"] = self.informationLabel
        self.itemDictionary["button"] = self.loginButton
        self.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.backgroundColor = .black
        self.loginButton.setTitleColor(.white, for: .normal)
        
        addObjects()
    }
    
    @objc func loginPressed(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else{
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
    }
    
    func addObjects(){
        self.view.addSubview(informationLabel)
        self.view.addSubview(loginButton)
        
        self.informationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.informationLabel.textColor = .black
        self.informationLabel.numberOfLines = 0
        self.informationLabel.textAlignment = .center
        self.informationLabel.text = "Login to view Winona Bars. If you are a bar it will take you the edit page for your bar."
        self.informationLabel.font = UIFont.systemFont(ofSize: 15)
        
        let constraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.itemDictionary)
        let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.itemDictionary)
        let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-400-[label]-20-[button]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.itemDictionary)

        self.view.addConstraints(constraint0)
        self.view.addConstraints(constraint1)
        self.view.addConstraints(constraint2)
    }
    
}

extension BarLoginView: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil{
            return
        }
        
        performSegue(withIdentifier: "goToBarPage", sender: self)
    }
}
