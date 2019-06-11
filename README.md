# EWImageTapBig
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)

图片点击全屏展示

# 实现功能:

一个extension文件实现图片点击全屏展示，再点击取消全屏。

<br>

![效果图预览](https://github.com/WangLiquan/EWImageTapBig/raw/master/images/demonstration.gif)

# 使用方法示例:
将EWImageAmplification文件拖入项目,调用时:
```
   /// 为imageView添加手势方法
   let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImageView))
   imageView.addGestureRecognizer(tap)
  
  @objc private func tapOnImageView() {
        EWImageAmplification.shared.scanBigImageWithImageView(currentImageView: imageView, alpha: 1)
    }
```
