//
//  DetailsViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 08/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

//import UIKit
import WebKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private var repoDetailsView: DetailsView!
    @IBOutlet private var webViewContainerView: UIView!
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var webViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var webViewContainerBottomConstrait: NSLayoutConstraint!
    
    var repoItem: GithubRepoViewModel?
    private var imageService: ImageServiceProtocol?
    
    private var isWebViewPresented = false
    private lazy var compactWebViewHeight: CGFloat = {
        return UIScreen.main.bounds.height - repoDetailsView.frame.origin.y - repoDetailsView.bounds.height - repoDetailsView.frame.origin.x
    }()
    private lazy var maximumWebViewHeight: CGFloat = {
        return UIScreen.main.bounds.height - repoDetailsView.frame.origin.y + 22
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageService = ImageService()
        webViewContainerView.alpha = 0.0
        
        setupDetailsView()
        showAvatar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupWebView()
    }
    
    private func setupDetailsView() {
        guard let data = repoItem else { return }
        repoDetailsView.configure(data: data, delegate: self)
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webViewContainerHeightConstraint.constant = compactWebViewHeight
        webViewContainerBottomConstrait.constant = -compactWebViewHeight
        
        guard let urlString = repoItem?.repoUrl, let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func showAvatar() {
        guard let data = repoItem else { return }
        imageService?.getImage(url: data.avatarUrl) { [weak self] image in
            self?.repoDetailsView.image = image
        }
    }
    
    @IBAction func closeButtonAction() {
        dismiss(animated: true)
    }
        
    @IBAction func webViewButtonAction(sender: UIButton) {
        isWebViewPresented.toggle()
        handleFullScreenWebView()
    }
    
    private func showWebView() {
        webViewContainerBottomConstrait.constant = 0
        webViewContainerView.alpha = 1.0
        animateView(withDuration: 1.0)
    }
    
    private func handleFullScreenWebView() {
        webViewContainerHeightConstraint.constant = isWebViewPresented ? maximumWebViewHeight : compactWebViewHeight
        animateView(withDuration: 0.3)
    }
    
    private func animateView(withDuration duration: Double) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension DetailsViewController: DetailsViewDelegate {
    func urlButtonTapped() {
        showWebView()
    }
}

extension DetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // TODO: error handling
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showWebView()
    }
}