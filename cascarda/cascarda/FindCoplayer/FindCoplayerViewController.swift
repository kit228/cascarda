//
//  FindCoplayerViewController.swift
//  cascarda
//
//  Created by Вениамин Китченко on 18.10.2021.
//

import UIKit

class FindCoplayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(with color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
