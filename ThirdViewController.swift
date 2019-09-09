//
//  ThirdViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var textInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
    }
}






// override func viewDidLoad() {
//   super.viewDidLoad()

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
//    }
//
//
//    @objc func backAction(){
//        dismiss(animated: true, completion: nil)
//    }


