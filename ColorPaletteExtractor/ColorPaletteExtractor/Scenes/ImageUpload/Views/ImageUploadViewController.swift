//
//  ImageUploadViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 13/04/21.
//

import UIKit

class ImageUploadViewController: UIViewController {
    let image: UIImage
    private let defaultInset: CGFloat = 20.0
    
    //MARK: - Circular progress view
    
    private lazy var circularPath: UIBezierPath = {
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: 40.0,
            startAngle: -.pi / 2,
            endAngle: 2 * .pi, clockwise: true
        )
        return circularPath
    }()
    
    private lazy var circularProgressBarLayer: CAShapeLayer = {
        let circularLayer = CAShapeLayer()
        circularLayer.path = circularPath.cgPath
        circularLayer.strokeColor = UIColor.systemPurple.cgColor
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.lineWidth = 7
        circularLayer.lineCap = .round
        circularLayer.strokeEnd = 0
        return circularLayer
    }()
    
    private lazy var trackProgressBarLayer: CAShapeLayer = {
        let circularLayer = CAShapeLayer()
        circularLayer.path = circularPath.cgPath
        circularLayer.strokeColor = UIColor.systemPurple.withAlphaComponent(0.5).cgColor
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.lineWidth = 7
        circularLayer.strokeEnd = 1
        return circularLayer
    }()
    
    //MARK: - Views
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: [])
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.cornerRadius = 10
        return imageView
    }()
    
    //MARK: - Actions
    
    @objc private func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //MARK: - Configuration
    
    private func configureViews() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultInset),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultInset),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 20.0),
            closeButton.heightAnchor.constraint(equalToConstant: 20.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultInset),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: defaultInset)
        ])
    }
    
    private func configureUploadProgressLayers() {
        view.layer.addSublayer(trackProgressBarLayer)
        view.layer.addSublayer(circularProgressBarLayer)
    }
    
    //MARK: - Lifecycle
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should never be called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureViews()
        configureUploadProgressLayers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.alpha = 0.5
//        for i in 0..<10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.circularProgressBarLayer.strokeEnd += 0.1
//            })
//        }
    }
}
