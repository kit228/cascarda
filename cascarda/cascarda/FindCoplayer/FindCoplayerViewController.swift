//
//  FindCoplayerViewController.swift
//  cascarda
//
//  Created by Вениамин Китченко on 18.10.2021.
//

import UIKit
import CoreMotion

class FindCoplayerViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    
    private var connectionStatus: ConnectionPlayersStatus = .searchPlayers {
        willSet {
            connectionStatusLabel.text = newValue.rawValue
            if newValue != .connected {
                loadingIndicator.startAnimating()
            }
        }
    }
    
    // MARK: - UI Elements
    
    private lazy var searchPlayersInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var connectionStatusLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        label.intrinsicContentSize.width
        return label
    }()
    
    private lazy var loadingIndicator = UIActivityIndicatorView()
    
    private lazy var arrowLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(150)
        label.textColor = .black
        label.text = Arrows.center.rawValue
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupMotion()
    }
    
    init(with color: UIColor) {
        self.connectionStatus = .searchPlayers
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Motion
    
    private func setupMotion() {
        motionManager.gyroUpdateInterval = 0.2
        var lastData: CMGyroData?
        motionManager.startGyroUpdates(to: OperationQueue.current!) { data, error in
            print(data?.rotationRate)
            if lastData == nil {
                lastData = data
            } else {
                if fabs(lastData?.rotationRate.x ?? 0) - fabs(data?.rotationRate.x ?? 0) > 0.8 {
                    self.arrowLabel.text = Arrows.up.rawValue
                }
                lastData = data
            }
        }
    }
    
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(searchPlayersInfoView)
        view.addSubview(arrowLabel)
        connectionStatusLabel.text = connectionStatus.rawValue
        loadingIndicator.startAnimating()
        searchPlayersInfoView.addSubview(connectionStatusLabel)
        searchPlayersInfoView.addSubview(loadingIndicator)
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        let arrowLabelAttributes: [NSLayoutConstraint.Attribute] = [.width, .height]
        NSLayoutConstraint.activate(arrowLabelAttributes.map {
            NSLayoutConstraint(item: arrowLabel, attribute: $0, relatedBy: .equal, toItem: nil, attribute: $0, multiplier: 1, constant: 200)
        })
        NSLayoutConstraint.activate([arrowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), arrowLabel.centerYAnchor.constraint(equalTo: searchPlayersInfoView.bottomAnchor, constant: 60)])
        
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
