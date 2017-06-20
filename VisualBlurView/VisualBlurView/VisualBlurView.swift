//
//  VisualBlureView.swift
//  VisualBlureView
//
//  Created by 冯成林 on 15/12/31.
//  Copyright © 2015年 冯成林. All rights reserved.
//

import UIKit

extension VisualBlurView {

    enum Style: Int {
    
        case extraLight
        case light
        case dark
    }

}

class VisualBlurExtraLightView: VisualBlurView {
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    override func viewprepare(){
        super.viewprepare()
        style = .extraLight
    }
}


class VisualBlurLightView: VisualBlurView {
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    override func viewprepare(){
        super.viewprepare()
        style = .light
    }
}


class VisualBlurDarkView: VisualBlurView {
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    override func viewprepare(){
        super.viewprepare()
        style = .dark
    }
}


class VisualBlurView: UIView {
    
    var style: Style!{didSet{styleKVO()}}

    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    fileprivate var vibrancyEffectBlurView: UIView!
    fileprivate var blurView: UIView!
    
    lazy var contentView: UIView  = {
    
        if #available(iOS 8.0, *) {
        
            let blurView = self.vibrancyEffectBlurView as! UIVisualEffectView
            
            return blurView.contentView
            
        }else {
            
            return self
        }
    }()
}


extension VisualBlurView {

    func viewprepare(){
        //清空背景色
        backgroundColor = nil
    }

    /** styleKVO */
    func styleKVO(){
        
        if #available(iOS 8.0, *) {
            if blurView == nil {
                let visualEffect = UIBlurEffect(style: UIBlurEffectStyle(rawValue: self.style.rawValue)!)
                let visualEffectView = UIVisualEffectView(effect: visualEffect)
                let vibrancyEffect = UIVibrancyEffect(blurEffect: visualEffect)
                vibrancyEffectBlurView = UIVisualEffectView(effect: vibrancyEffect)
                visualEffectView.contentView.addSubview(vibrancyEffectBlurView)
                vibrancyEffectBlurView.layoutView_ForBlurViewFrameWork()
                blurView = visualEffectView
                addSubview(blurView)
                blurView.layoutView_ForBlurViewFrameWork()
            }
        }else {
            if blurView == nil {
                let toolBar = UIToolbar()
                toolBar.barStyle = style == .dark ? .black : .default
                vibrancyEffectBlurView = toolBar
                blurView = toolBar
                addSubview(blurView)
                blurView.layoutView_ForBlurViewFrameWork()
            }else {
                let toolBar = blurView as! UIToolbar
                toolBar.barStyle = style == Style.dark ? UIBarStyle.black : UIBarStyle.default
            }
        }
    }
}

extension UIView {
    
    func layoutView_ForBlurViewFrameWork() {
        if superview == nil {return}
        translatesAutoresizingMaskIntoConstraints = false
        let views = ["layoutView": self]
        let c_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[layoutView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let c_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[layoutView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        superview!.addConstraints(c_V); superview!.addConstraints(c_H)
    }
}
