//
//  StartupViewController.swift
//  cascarda
//
//  Created by Вениамин Китченко on 18.10.2021.
//

import UIKit

class StartupViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startMainMenueViewController()
    }
    
    // MARK: - Routing
    
    private func startMainMenueViewController() {
        let mainMenue = MainMenueViewController()
        mainMenue.modalTransitionStyle = .crossDissolve
        mainMenue.modalPresentationStyle = .fullScreen
        self.present(mainMenue, animated: true)
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.953619722, green: 0.9103077525, blue: 1, alpha: 1)
    }

}
