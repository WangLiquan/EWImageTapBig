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

    /// 点击放大方法
    ///
    /// - Parameters:
    ///   - currentImageView: 要放大的imageView
    ///   - alpha: 背景透明度(0-1)
    func scanBigImageWithImageView(currentImageView: UIImageView, alpha: CGFloat) {
        let image = currentImageView.image
        /// 获取keyWindow
        let window = UIApplication.shared.keyWindow
        let backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: EWidth, height: EHeight))
        /// 记录imageView初始frame，保证复原
        oldFrame = currentImageView.convert(currentImageView.bounds, to: window)
        let imageView = UIImageView(frame: oldFrame)
        backGroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        backGroundView.alpha = 0

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        backGroundView.addSubview(imageView)
        backGroundView.isUserInteractionEnabled = true
        window?.addSubview(backGroundView)
        /// 为背景View添加手势方法，实现点击复原
        let tap: EWTap = EWTap(target: self, action: #selector(tapOnBackView(_:)))
        tap.backView = backGroundView
        tap.imageView = imageView
        backGroundView.addGestureRecognizer(tap)
        /// 实现动画效果
        UIView.animate(withDuration: 0.4) {
            let imageY: CGFloat = (EHeight - (image?.size.height)! * EWidth / (image?.size.width)!) * 0.5
            let height = (image?.size.height)! * EWidth / (image?.size.width)!
            imageView.frame = CGRect(x: 0, y: imageY, width: EWidth, height: height)
            backGroundView.alpha = 1
        }
    }
    
    /// 点击背景手势方法
    ///
    /// - Parameter sender: 手势
    @objc private func tapOnBackView(_ sender: EWTap) {
        UIView.animate(withDuration: 0.4, animations: {
            sender.imageView?.frame = oldFrame
            sender.backView?.alpha = 0
        }, completion: { (_) in
            sender.backView?.removeFromSuperview()
        })
    }
}
/// 自定义手势类，实现手势方法传参
class EWTap: UITapGestureRecognizer {
    var backView: UIView?
    var imageView: UIImageView?
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
}
