//
//  EWImageAmplification.swift
//  EWImageTapBig
//
//  Created by Ethan.Wang on 2019/5/29.
//  Copyright © 2019 王利权. All rights reserved.
//
import UIKit

var oldFrame: CGRect = CGRect()

let EWidth = UIScreen.main.bounds.width
let EHeight = UIScreen.main.bounds.height

class EWImageAmplification: NSObject {
    static let shared = EWImageAmplification()
    private let backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: EWidth, height: EHeight))
    
    private let imageView = UIImageView(frame: oldFrame)

    func scanBigImageWithImageView(currentImageView: UIImageView, alpha: CGFloat){
        let image = currentImageView.image
        let window = UIApplication.shared.keyWindow
        
        oldFrame = currentImageView.convert(currentImageView.bounds, to: window)
        backGroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        backGroundView.alpha = 0
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        backGroundView.addSubview(imageView)
        backGroundView.isUserInteractionEnabled = true
        window?.addSubview(backGroundView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnBackView(_:)))
        backGroundView.addGestureRecognizer(tap)
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            let y: CGFloat = (EHeight - (image?.size.height)! * EWidth / (image?.size.width)!) * 0.5
            let height = (image?.size.height)! * EWidth / (image?.size.width)!
            self?.imageView.frame = CGRect(x: 0, y: y, width: EWidth, height: height)
            self?.backGroundView.alpha = 1
        }
    }
    
    @objc private func tapOnBackView(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.imageView.frame = oldFrame
            self?.backGroundView.alpha = 0
        }, completion: { [weak self] (finished) in
            self?.backGroundView.removeFromSuperview()
        })
    }
}
