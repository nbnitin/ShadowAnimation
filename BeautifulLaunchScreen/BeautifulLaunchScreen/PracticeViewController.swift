//
//  PracticeViewController.swift
//  BeautifulLaunchScreen
//
//  Created by Nitin Bhatia on 13/10/22.
//

import UIKit

class PracticeViewController: UIViewController {
    
    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var roundedVV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addShadow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.runShadow()
        })
        
        makeViewRoundAndImageToCircumference()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func addShadow() {
        lblText.shadowColor = .white
        
    }
    
    func runShadow() {
        let trig = calculateTrigno(segements: .x,angle: 45,size: 10)
        UIView.animate(withDuration: 10.0, delay: 0, animations: {
            //self.lblText.shadowOffset = CGSize(width: trig[.x]!, height: trig[.y]!)
            
            self.roundedVV.center.y += 90
            
            let x = self.roundedVV.layer.cornerRadius * cos(10.0 * .pi/180) + self.roundedVV.center.x - 10
            let y = self.roundedVV.layer.cornerRadius * cos(90.0 * .pi/180) + self.roundedVV.center.y - 10
            
            
            
            
            //UIView.animate(withDuration: 10.0, delay: 0, animations: {
                self.imageView.frame.origin.x = x
                self.imageView.frame.origin.y = y
           // })
            
            
        },completion: {_ in
            
        })
        
        
    }
    var imageView : UIImageView!
    
    func makeViewRoundAndImageToCircumference() {
        roundedVV.layer.cornerRadius = roundedVV.frame.width / 2
        let trig = calculateTrigno(segements: .h, angle: 10, size: roundedVV.frame.width)
        
        let x = roundedVV.layer.cornerRadius * cos(10.0 * .pi/180) + roundedVV.center.x - 10
        let y = roundedVV.layer.cornerRadius * cos(90.0 * .pi/180) + roundedVV.center.y - 10
         imageView = UIImageView(frame: CGRect(x: x, y: y, width: 20, height: 20))
        let gest = UITapGestureRecognizer(target: self, action: #selector((imgTapped)))
        imageView.addGestureRecognizer(gest)
        imageView.isUserInteractionEnabled = true
        let img = UIImage(systemName: "pencil.circle.fill")
        imageView.tintColor = .gray
        imageView.image = img
        view.addSubview(imageView)
       // imageView.sendSubviewToBack(roundedVV)
    }
    
    @objc func imgTapped() {
        print("hello i m image")
    }
    
    
    func calculateTrigno(segements:Segments,angle:CGFloat,size:CGFloat)->[Segments:CGFloat] {
        
        switch segements {
            
        case .x:
            
            let x = size
            let y = tan(angle * .pi/180) * x
            let h = x / cos(angle * .pi/180)
            return [ .x : x, .y : y, .h : h ]
            
        case .y:
            
            let y = size
            let x = tan(angle * .pi/180) * y
            let h = y / sin(angle * .pi/180)
            return [ .x : x, .y : y, .h : h ]
            
        case .h:
            
            let h = size
            let y = sin(angle * .pi/180) * h
            let x = cos(angle * .pi / 180) * h
            return[Segments.x:x,Segments.y:y,Segments.h:h]
            
        }
        
    }
}

enum Segments {
    case x
    case y
    case h
}
