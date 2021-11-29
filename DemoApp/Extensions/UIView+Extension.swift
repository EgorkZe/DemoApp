//
//  UIView+Extension.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: CONSTANTS
    enum Constants {
        static let tag = 11111
        static let indicatorSideWidth: CGFloat = 44
        static let animationDuration = 0.25
    }
    
    // MARK: - ALIASES
    
    typealias ActivityIndicatorStyle = UIActivityIndicatorView.Style
    
    // MARK: - PUBLIC FIELDS
    
    var activityIndicatorStyle: ActivityIndicatorStyle = .medium
    
    // MARK: - PRIVATE FIELDS
    
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - LIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(activityIndicatorStyle: ActivityIndicatorStyle = .medium,
                         backGroundColor: UIColor = .white,
                         frame: CGRect) {
        self.activityIndicatorStyle = activityIndicatorStyle
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        setup()
    }
    
    // MARK: - SETUP
    
    private func setup() {
        tag = Constants.tag
        translatesAutoresizingMaskIntoConstraints = false
        activityIndicator = buildActivityIndicator()
        addSubview(activityIndicator!)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator!.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator!.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator!.heightAnchor.constraint(equalToConstant: Constants.indicatorSideWidth),
            activityIndicator!.widthAnchor.constraint(equalToConstant: Constants.indicatorSideWidth)
        ])
    }
    
    // MARK: - PRIVATE METHODS
    
    private func buildActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = activityIndicatorStyle
        return activityIndicator
    }
    
    // MARK: - PUBLIC API
    
    /// Starts the loading animation
    func startAnimating() {
        activityIndicator?.startAnimating()
    }
    
    /// Stops the loading animation
    func stopAnimating() {
        activityIndicator?.stopAnimating()
    }
}

/// This extension makes possible to call a loading indicator on
/// anything that inherits from UIView
extension UIView {
    
    func showLoading(style: LoadingView.ActivityIndicatorStyle = .medium,
                               backgroundColor: UIColor = .white) {
        let loadingView = LoadingView(activityIndicatorStyle: style,
                                      backGroundColor: backgroundColor,
                                      frame: .zero)
        loadingView.activityIndicatorStyle = style
        loadingView.backgroundColor = backgroundColor
        addSubview(loadingView)
        loadingView.startAnimating()
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
    }
    
    /// Tries to hide the loadingView that is visible
    func hideLoading() {
        let loadingView = viewWithTag(LoadingView.Constants.tag)
        UIView.animate(withDuration: LoadingView.Constants.animationDuration, animations: {
            loadingView?.alpha = 0
        }, completion: { completed in
            if completed {
                (loadingView as? LoadingView)?.stopAnimating()
                loadingView?.removeFromSuperview()
            }
        })
    }
}
