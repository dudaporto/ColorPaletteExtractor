//
//  ExtractedPaletteViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 16/04/21.
//

import UIKit

class ExtractedPaletteViewController: UIViewController {
    let image: UIImage
    
    // MARK: - Views
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.cornerRadius = 10
        return view
    }()
    
    private lazy var imageHeaderView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Configuration
    
    private func configureViews() {
        view.addSubview(imageHeaderView)
        view.insertSubview(contentView, aboveSubview: imageHeaderView)
        contentView.addSubview(tableView)
        
        tableView.fitToParent()
        
        imageHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            imageHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageHeaderView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: imageHeaderView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Lifecycle
    
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
        
        configureNavigationBar()
        configureViews()
    }
}
