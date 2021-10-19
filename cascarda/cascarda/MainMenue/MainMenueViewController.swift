//
//  MainMenueViewController.swift
//  cascarda
//
//  Created by Вениамин Китченко on 18.10.2021.
//

import UIKit

class MainMenueViewController: UIViewController {
    
    //private let startButtonColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    private let startButtonColor = #colorLiteral(red: 0.07408587842, green: 0.9852093003, blue: 1, alpha: 1)
    
    private var arrrayOfColors = [#colorLiteral(red: 0.557222512, green: 0.8085616312, blue: 1, alpha: 1), #colorLiteral(red: 0.742261254, green: 0.8079684041, blue: 1, alpha: 1)]
    private var backgroundColorsLoop = 0
    private var backgroundColorsLoopIsOn = true
    
    // MARK: - UI Elements
    
    private lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.setTitle("Start", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 45)
        button.backgroundColor = startButtonColor
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var upArrow: UILabel = {
        let label = UILabel()
        //label.text = Arrows.allCases.randomElement()?.rawValue
        label.text = Arrows.up.rawValue
        label.font = label.font.withSize(150)
        label.textColor = .white
        return label
    }()
    
    private lazy var rightArrow: UILabel = {
        let label = UILabel()
        label.text = Arrows.right.rawValue
        label.font = label.font.withSize(150)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    // MARK: - Animations
    
    private func animateBackgroundColor() {
        guard backgroundColorsLoopIsOn else { return }
        if backgroundColorsLoop < arrrayOfColors.count - 1 {
            backgroundColorsLoop += 1
        } else {
            backgroundColorsLoop = 0
        }
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.allowUserInteraction) {
            self.view.backgroundColor = self.arrrayOfColors[self.backgroundColorsLoop]
        } completion: { _ in
            self.animateBackgroundColor()
        }
    }
    
    private func removeAnimateBackgroundColor() {
        self.backgroundColorsLoopIsOn = false
        //self.view.layer.removeAllAnimations()
    }
    
    private func moveButtonUp() {
        UIView.animate(withDuration: 1) {
            self.startGameButton.center.y = -300
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.allowUserInteraction) {
                self.view.backgroundColor = .white
            } completion: { isFinished in
                if isFinished {
                    self.toFindCoplayer()
                }
            }
            
        }

    }
    
    // MARK: - Button settings
    
    private func setupStartButtonTap() {
        startGameButton.addTarget(self, action: #selector(startTap), for: .touchUpInside)
    }
    
    @objc func startTap() {
        removeAnimateBackgroundColor()
        moveButtonUp()
    }
    
    // MARK: - Routing
    
    private func toFindCoplayer() {
        //let findCoplayerViewController = FindCoplayerViewController(with: view.backgroundColor ?? .cyan)
        let findCoplayerViewController = FindCoplayerViewController(with: view.backgroundColor ?? .white)
        findCoplayerViewController.modalPresentationStyle = .fullScreen
        findCoplayerViewController.modalTransitionStyle = .crossDissolve
        self.present(findCoplayerViewController, animated: false, completion: nil)
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        animateBackgroundColor()
        view.addSubview(startGameButton)
        view.addSubview(upArrow)
        view.addSubview(rightArrow)
        setupConstraints()
        setupStartButtonTap()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startGameButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        startGameButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        upArrow.translatesAutoresizingMaskIntoConstraints = false
        let upArrowAttributes: [NSLayoutConstraint.Attribute] = [.width, .height]
        NSLayoutConstraint.activate(upArrowAttributes.map {
            NSLayoutConstraint(item: upArrow, attribute: $0, relatedBy: .equal, toItem: nil, attribute: $0, multiplier: 1, constant: 300)
        })
        NSLayoutConstraint.activate([upArrow.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -40), upArrow.centerYAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 80)])
        
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        let rightArrowAttributes: [NSLayoutConstraint.Attribute] = [.width, .height]
        NSLayoutConstraint.activate(rightArrowAttributes.map {
            NSLayoutConstraint(item: rightArrow, attribute: $0, relatedBy: .equal, toItem: nil, attribute: $0, multiplier: 1, constant: 300)
        })
        NSLayoutConstraint.activate([rightArrow.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 130), rightArrow.centerYAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 250)])
        
    }

}
