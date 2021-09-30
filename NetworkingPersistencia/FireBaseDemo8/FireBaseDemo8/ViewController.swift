//
//  ViewController.swift
//  FireBaseDemo8
//
//  Created by Douglas Frari on 9/4/21.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }


}

