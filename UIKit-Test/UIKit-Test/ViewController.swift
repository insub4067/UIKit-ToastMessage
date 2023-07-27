//
//  ViewController.swift
//  UIKit-Test
//
//  Created by 김인섭 on 2023/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setButton()
    }
    
    func setButton() {
        button = .init(primaryAction: .init(handler: { _ in
            self.showToast(message: "Toast Message")
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        button.setTitle("Show Toast", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension UIViewController {
    
    private var scene: UIWindowScene? { UIApplication.shared.connectedScenes.first as? UIWindowScene }
    private var root: UIViewController? { scene?.windows.first?.rootViewController }
    
    func showToast(message: String) {
        
        guard view.viewWithTag(.toastTag) == nil else { return }
        
        let y: CGFloat = 90
        let duration: CGFloat = 0.25
        let hPadding: CGFloat = 16
        
        let label = UILabel(frame: .init(
            x: hPadding,
            y: 0,
            width: (root?.view.frame.width ?? 0) - (hPadding * 2),
            height: 60)
        )
        label.text = message
        label.backgroundColor = .black
        label.textAlignment = .center
        label.alpha = 0
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.textColor = .white
        label.tag = .toastTag
        
        root?.view.addSubview(label)
        
        UIView.animate(withDuration: duration) {
            label.center.y = y
            label.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: duration) {
                label.center.y = -y
                label.alpha = 0
            } completion: { _ in
                label.removeFromSuperview()
            }
        }
    }
}

extension Int {
    
    static let toastTag = 111
}
