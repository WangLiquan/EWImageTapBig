//
//  ViewController.swift
//  EWImageTapBig
//
//  Created by Ethan.Wang on 2019/5/29.
//  Copyright © 2019 王利权. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (EWidth - 182) / 2, y: 250, width: 182, height: 103.5))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "back")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }
    private func drawMyView() {
        self.view.addSubview(imageView)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageView))
        imageView.addGestureRecognizer(tap)
    }
    @objc private func tapOnImageView() {
        EWImageAmplification.shared.scanBigImageWithImageView(currentImageView: imageView, alpha: 1)
    }

}
