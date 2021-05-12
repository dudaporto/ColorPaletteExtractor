//
//  ImageUploadViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 13/04/21.
//

import UIKit

class ImageUploadViewController: UIViewController {
    let image: UIImage
    private let animationDuration: TimeInterval = 0.4
    private let defaultCornerRadius: CGFloat = 10.0
    private let defaultInset: CGFloat = 20.0
    
    //MARK: - Views
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.cornerRadius = defaultCornerRadius
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.cornerRadius = defaultCornerRadius
        return imageView
    }()
    
    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.cornerRadius = defaultCornerRadius
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.text = "0%"
        return label
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = defaultInset
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.text = "Uploading image..."
        return label
    }()
    
    private lazy var uploadProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        progressView.progressTintColor = .systemPurple
        progressView.trackTintColor = .systemGray3
        
        progressView.layer.sublayers?.forEach {
            $0.cornerRadius = 5
        }
        
        progressView.subviews.forEach {
            $0.clipsToBounds = true
        }
        
        return progressView
    }()
    
    //MARK: - Constraints
    
    private lazy var contentViewCenterYConstraint: NSLayoutConstraint = {
        let contraint = contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        return contraint
    }()
    
    //MARK: - Actions
    
    @objc private func rootViewTapped() {
        performCustomDisappearingAnimation { _ in
            self.dismiss(animated: false)
        }
    }
    
    //MARK: - Configuration
    
    private func configureViews() {
        view.addSubview(contentView)
        contentView.addSubview(itemsStackView)
        imageViewContainer.addSubview(imageView)
        itemsStackView.addArrangedSubviews(imageViewContainer, titleLabel, uploadProgressView, progressLabel)
        
        imageView.fitToParent()
        imageViewContainer.setAspectRatio(1)
        itemsStackView.fitToParent(with: UIEdgeInsets(inset: defaultInset))
        
        uploadProgressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        let contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: view.bottomAnchor)
        contentViewTopConstraint.priority = .defaultLow
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: defaultInset),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultInset),
            contentViewTopConstraint
        ])
    }
    
    private func performCustomAppearingAnimation() {
        contentViewCenterYConstraint.isActive = true
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.view.layoutIfNeeded()
        })
    }
    
    private func performCustomDisappearingAnimation(_ completion: @escaping ((Bool) -> Void)) {
        contentViewCenterYConstraint.isActive = false
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    //MARK: - Lifecycle
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should never be called")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rootViewTapped)))
        self.view = view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewContainer.dropSimpleBottomShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.isNavigationBarHidden = true
        
        configureViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        performCustomAppearingAnimation()
    }
}
