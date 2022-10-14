//
//  ViewController.swift
//  BeautifulLaunchScreen
//
//  Created by Nitin Bhatia on 13/10/22.
//

import UIKit

let INITIAL_ANGLE : CGFloat = 22.5

class ViewController: UIViewController {
    
    @IBOutlet weak var lblWelcomeText: UILabel!
    
    
    // dark view to add light effect
    lazy var shadowView: UIView = {
        let v = UIView()
        v.frame = view.bounds
        v.alpha = 0.9
        v.backgroundColor = UIColor(named: "darkness")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add light effect view
        view.addSubview(shadowView)
        view.bringSubviewToFront(shadowView)
        
        // set initial shadow: shadowOffset
        lblWelcomeText.alpha = 0
        lblWelcomeText.layer.shadowColor = UIColor.black.cgColor
        lblWelcomeText.layer.shadowRadius = 5
        lblWelcomeText.layer.shadowOpacity = 1
        lblWelcomeText.layer.shadowOffset = CGSize(width: 10, height: 0)
        
        // start animation: shadowOffset
        self.rightShadow()
        
    }
    
    
    
    // MARK: - Calculate trigonometry
    
    // calculate x and y points of the shadow to make it move in circular motion
    func calcTrig(segment: segment, size: CGFloat, angle: CGFloat) -> [segment : CGFloat] {
        
        switch segment {
            
        case .x:
        
            let x = size
            let y = tan(angle * .pi/180) * x
            let h = x / cos(angle * .pi/180)
            return [ .x : x, .y : y, .h : h]
            
        case .y:
            
            let y = size
            let x = y / tan(angle * .pi/180)
            let h = y / sin(angle * .pi/180)
            return [ .x : x, .y : y, .h : h]
            
        case .h:
            
            let h = size
            let x = cos(angle * .pi/180) * h
            let y = sin(angle * .pi/180) * h
            return [ .x : x, .y : y, .h : h]
            
        }
        
    }
    
    
    // MARK: - Shadow using shadowOffset
    // shadow on the right, label starts appearing, light effect view makes view darker
    func rightShadow() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            
            self.lblWelcomeText.alpha = 0.75
            self.shadowView.alpha = 0.6
            
        } completion: { success in
            
            // move it lower
            self.rightHalfBottomShadow()
            
        }
        
    }
    
    // move shadow a bit lower, label fully appeared, light effect view gets lighter
    func rightHalfBottomShadow() {
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear) {
            
            self.lblWelcomeText.alpha = 1
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.5
            
        } completion: { success in
            
            self.rightBottomShadow()
            
        }
        
    }
    
    
    
    // move shadow to bottom right, light effect view creates light effect
    func rightBottomShadow() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 2)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.4
            
        } completion: { success in
            
            self.halfRightBottomShadow()
            
        }
        
    }
    
    // move shadow more to the bottom, light eeffect view gets lighter
    func halfRightBottomShadow() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 3)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.2
            
        } completion: { success in
            
            self.bottomShadow()
            
        }
        
    }
    
    // shadow is at the bottom, light effect view gets slightly darker
    func bottomShadow() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 4)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.3
            
        } completion: { success in
            
            self.halfLeftBottomShadow()
            
        }
        
    }
    
    // shadow moves to the left and light effect view makes view darker
    func halfLeftBottomShadow() {
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 5)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.5
            
        } completion: { success in
            
            self.leftBottomShadow()
            
        }
        
    }
    
    // shadow moves to the bottom left and light effect view gets dark
    func leftBottomShadow() {
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 6)
            let x = trig[.x]
            let y = trig[.y]
            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.7
            
        } completion: { success in
            
            self.rightShadow()
            
        }
        
    }
    
//    func leftHalfBottomShadow() {
//
//        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
//
//            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 9)
//            let x = trig[.x]
//            let y = trig[.y]
//            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
//            self.shadowView.alpha = 0.0
//
//        } completion: { success in
//
//            self.resetShadow()
//
//        }
//
//    }
    
//    func resetShadow() {
//
//        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
//
//            let trig = self.calcTrig(segment: .h, size: 10, angle: INITIAL_ANGLE * 14)
//            let x = trig[.x]
//            let y = trig[.y]
//            self.lblWelcomeText.layer.shadowOffset = CGSize(width: x!, height: y!)
//            self.shadowView.alpha = 0.0
//
//        } completion: { success in
//
//            self.rightShadow()
//
//        }
//
//    }
    
}


enum segment {
    
    case x
    case y
    case h
    
}



