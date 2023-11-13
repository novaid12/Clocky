//
//  AuthVC.swift
//  Clocky
//
//  Created by  NovA on 30.10.23.
//

import UIKit
import WebKit

class AuthVC: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        return webView
    }()

    public var complitionHandler: ((Bool) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = view.bounds
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        guard let component = URLComponents(string: url.absoluteString),
              let code = component.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in

            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.complitionHandler?(success)
                self?.dismiss(animated: true)
            }
        }
    }

    private func setupUI() {
        super.viewWillAppear(true)
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }
    
        deinit {
            print("deinit AuthVC")
        }
}
