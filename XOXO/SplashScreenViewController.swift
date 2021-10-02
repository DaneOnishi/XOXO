//
//  SplashScreenViewController.swift
//  XOXO
//
//  Created by Daniella Onishi on 01/10/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var xoxoLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3,
                       delay: 4,
                       options: .curveEaseInOut) {
            self.xoxoLogo.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 4,
                           options: .curveEaseInOut) {
                self.xoxoLogo.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.3,
                               delay: 4,
                               options: .curveEaseInOut) {
                    self.xoxoLogo.alpha = 0
                    
                } completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                        let storyboard = UIStoryboard(name: "ArchivesViewController", bundle: nil)
                        guard let homeVC = storyboard.instantiateViewController(identifier: "ArchivesViewController") as? ArchivesViewController else {
                            return
                        }
                        homeVC.modalPresentationStyle = .fullScreen
                        self.present(homeVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
