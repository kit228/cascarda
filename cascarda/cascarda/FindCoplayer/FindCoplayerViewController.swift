//
//  FindCoplayerViewController.swift
//  cascarda
//
//  Created by Вениамин Китченко on 18.10.2021.
//

import UIKit

class FindCoplayerViewController: UIViewController {
    
    private var connectionStatus: ConnectionPlayersStatus = .searchPlayers {
        willSet {
            connectionStatusLabel.text = newValue.rawValue
            if newValue != .connected {
                loadingIndicator.startAnimating()
            }
        }
    }
    
    // MARK: - UI Elements
    
    private let searchPlayersInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 40
        return view
    }()
    
    private var connectionStatusLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        label.intrinsicContentSize.width
        return label
    }()
    
    var loadingIndicator = UIActivityIndicatorView()
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    init(with color: UIColor) {
        self.connectionStatus = .searchPlayers
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animations
    
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(searchPlayersInfoView)
        connectionStatusLabel.text = connectionStatus.rawValue
        loadingIndicator.startAnimating()
        searchPlayersInfoView.addSubview(connectionStatusLabel)
        searchPlayersInfoView.addSubview(loadingIndicator)
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        searchPlayersInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchPlayersInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor), searchPlayersInfoView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150)])
        searchPlayersInfoView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchPlayersInfoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([loadingIndicator.trailingAnchor.constraint(equalTo: connectionStatusLabel.leadingAnchor, constant: -5), loadingIndicator.centerYAnchor.constraint(equalTo: searchPlayersInfoView.centerYAnchor)])
        
        connectionStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([connectionStatusLabel.centerXAnchor.constraint(equalTo: searchPlayersInfoView.centerXAnchor), connectionStatusLabel.centerYAnchor.constraint(equalTo: searchPlayersInfoView.centerYAnchor)])
        
    }
    
}
