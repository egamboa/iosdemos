//
//  ViewController.swift
//  trabajoenclase2-6
//
//  Created by Andrés Gamboa on 6/2/18.
//  Copyright © 2018 Andrés Gamboa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labelPositionIsLeft = true
    @IBOutlet weak var currentLabelValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var animateMeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func rotateAction(_ sender: Any) {
        UIView.animate(withDuration: 2.0, animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        })
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
    }
    
    @IBAction func startAnimation(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            if self.labelPositionIsLeft {
                self.animateMeLabel.center.x = self.view.bounds.width - 100
            }
            else {
                self.animateMeLabel.center.x = 100
            }
            self.labelPositionIsLeft = !(self.labelPositionIsLeft)
        }, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        currentLabelValue.text = "\(currentValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        let halfSizeOfView = 25.0
        let maxViews = 1
        let insetSize = self.view.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size
        
        // Add the Views
        for _ in 0..<maxViews {
            let pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
            let pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            let newView = MyView(frame: CGRect(x: pointX, y: pointY, width: 50, height: 50))
            self.view.addSubview(newView)
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            print("Swipe Left")
            let labelPosition = CGPoint(x: self.currentLabelValue.frame.origin.x - 50.0, y: self.currentLabelValue.frame.origin.y)
            currentLabelValue.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.currentLabelValue.frame.size.width, height: self.currentLabelValue.frame.size.height)
        }
        
        if (sender.direction == .right) {
            print("Swipe Right")
            let labelPosition = CGPoint(x: self.currentLabelValue.frame.origin.x + 50.0, y: self.currentLabelValue.frame.origin.y)
            currentLabelValue.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.currentLabelValue.frame.size.width, height: self.currentLabelValue.frame.size.height)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

