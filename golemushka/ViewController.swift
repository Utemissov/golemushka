//
//  ViewController.swift
//  golemushka
//
//  Created by Алем Утемисов on 19.04.16.
//  Copyright © 2016 Алем Утемисов. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var golemImg: GolemImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var foodImg: DragImg!
    
    @IBOutlet weak var law1: UIImageView!
    @IBOutlet weak var law2: UIImageView!
    @IBOutlet weak var law3: UIImageView!
    
    var bgMusic : AVAudioPlayer!
    var sfxBite : AVAudioPlayer!
    var sfxHeart : AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var selected : UInt32 = 0
    
    
    var laws = 0
    var timer : NSTimer! = nil
    var happy = true
    override func viewDidLoad() {
        super.viewDidLoad()
        law1.alpha = 0.2
        law2.alpha = 0.2
        law3.alpha = 0.2
        heartImg.dropTarget = golemImg
        foodImg.dropTarget = golemImg
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDropped(_:)), name: "onTargetDrop", object: nil)
        do{
            try bgMusic = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            bgMusic.prepareToPlay()
            bgMusic.play()
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
    }
    
    
    func itemDropped(notif: AnyObject?){
        happy = true
        startTimer()
        heartImg.alpha = 0.2
        heartImg.userInteractionEnabled = false
        foodImg.alpha = 0.2
        foodImg.userInteractionEnabled = false
        if selected == 0{
            sfxBite.play()
        }else{
            sfxHeart.play()
        }
       
    }
    
    
    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    func changeGameState(){
        if !happy{
            sfxSkull.play()
            laws++
            if laws == 1{
                law1.alpha = 1.0
                law2.alpha = 0.2
            }else if laws == 2{
                law2.alpha = 1.0
            }else if laws >= 3{
                law3.alpha = 1.0
            }else{
                law1.alpha = 0.2
                law2.alpha = 0.2
                law3.alpha = 0.2
            }
            if laws >= 3{
                gameOver()
            }
        }
        let rand = arc4random() % 2
        if rand == 0{
            heartImg.alpha = 0.2
            heartImg.userInteractionEnabled = false
            foodImg.alpha = 1.0
            foodImg.userInteractionEnabled = true
        }else{
            foodImg.alpha = 0.2
            foodImg.userInteractionEnabled = false
            heartImg.alpha = 1.0
            heartImg.userInteractionEnabled = true
        }
        selected = rand
        happy = false
    }
    func gameOver(){
        timer.invalidate()
        golemImg.playDead()
        sfxDeath.play()
    }




}

