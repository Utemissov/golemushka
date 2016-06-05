//
//  GolemImg.swift
//  golemushka
//
//  Created by Алем Утемисов on 20.02.16.
//  Copyright © 2016 Алем Утемисов. All rights reserved.
//

import Foundation
import UIKit

class GolemImg: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playAlive()
    }
    func playAlive(){
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        var images = [UIImage]()
        for i in 1 ... 4{
            images.append(UIImage(named: "idle\(i).png")!)
        }
        self.animationImages = images
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    func playDead(){
       
        self.image = UIImage(named: "dead5.png")
                self.animationImages = nil
        var images = [UIImage]()
        for i in 1 ... 5{
            images.append(UIImage(named: "dead\(i).png")!)
        }
        self.animationImages = images
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
  
}