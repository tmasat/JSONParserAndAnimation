//
//  Motion.swift
//  ReadJSONAndMotion
//
//  Created by Çağrı Tuğberk MASAT on 6.09.2019.
//  Copyright © 2019 Çağrı Tuğberk MASAT. All rights reserved.
//


import UIKit

class Motion: UIViewController {
    
    var getName = String()
    var getImage = String()
    var getBackgroundImage = String()
    
    
    var seconds = 3
    var timer = Timer()
    
    
    let pokeballModels = ["pokeball0", "pokeball1", "pokeball2"]
    
    var square1 = UIButton()
    var square2 = UIButton()
    var square3 = UIButton()
    var square4 = UIButton()
    
    
    var northwest = CGPoint()
    var northeast = CGPoint()
    var southwest = CGPoint()
    var southeast = CGPoint()
    
    
    var radius = CGFloat()
    var radius2 = CGFloat()
    
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgBackgroundImage: UIImageView!
    @IBOutlet weak var buttonChangeImage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        imgImage.image = UIImage(named: getImage)
        lblName.text! = getName
        imgBackgroundImage.image = UIImage(named: getBackgroundImage)
    }
    
    //MARK: - Touches on Squares
    
    @objc func buttonAction(sender: UIButton) {
        print("Touched on square")
    }
    
    
    //MARK: - Button Pressed
    //**************************************************************************
    @IBAction func buttonPressed(_ sender: UIButton) {
        buttonChangeImage.isUserInteractionEnabled = false
        centerSquaresFunction(uiButton: square1)
        centerSquaresFunction(uiButton: square2)
        centerSquaresFunction(uiButton: square3)
        centerSquaresFunction(uiButton: square4)
        
        buttonChangeImage.setImage(UIImage(named: "pokeball3"), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (counter), userInfo: nil, repeats: true)
    }
    
    //MARK: - Squares set on center of the screen
    func centerSquaresFunction (uiButton: UIButton){
        
        uiButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        uiButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        uiButton.center.x = (view.bounds.width / 2)
        uiButton.center.y = (view.bounds.height / 2)
        uiButton.backgroundColor = UIColor.green
        view.addSubview(uiButton)
    }
    
    
    //MARK: - 3 Seconds Timer
    @objc func counter(){
        seconds -= 1
        buttonChangeImage.setImage(UIImage(named: pokeballModels[seconds]), for: .normal)
        
                if (seconds == 0) {
                    
                        seconds = 4 //To use in animationMaker()
                        timer.invalidate()
                        animationAdjuster()
        }
    }
    
    //MARK: - Divide the Screen
    func animationAdjuster(){
        
        let screenLeftPart = (view.bounds.width / 2) - (view.bounds.width / 12)
        let screenRightPart = (view.bounds.width / 2) + (view.bounds.width / 12)
        let screenTopPart = (view.bounds.height / 2) - (view.bounds.height / 12)
        let screenBottomPart = (view.bounds.height / 2) + (view.bounds.height / 12)
        
        northwest = CGPoint(x: screenLeftPart, y: screenTopPart)
        northeast = CGPoint(x: screenRightPart, y: screenTopPart)
        southwest = CGPoint(x: screenLeftPart, y: screenBottomPart)
        southeast = CGPoint(x: screenRightPart, y: screenBottomPart)
        
        radius = 130
        radius2 = 70
        
        animationStarter()
    }
    
    func animationStarter(){
        timer = Timer.scheduledTimer(timeInterval: 0.070, target: self, selector: #selector (animationMaker), userInfo: nil, repeats: true)
    }
    
    
    @objc func animationMaker(){
        
        seconds -= 1
        
        
        let t = CGFloat(M_PI) / 25 * CGFloat(seconds)
      
        square1.center.x = sin(-t) * radius2 + northwest.x
        square1.center.y = cos(-t) * radius2 + northwest.y
        
        square2.center.x = sin(t) * radius2 + southwest.x
        square2.center.y = cos(t) * radius2 + southwest.y
        
        square3.center.x = sin(t) * radius + northeast.x
        square3.center.y = cos(t) * radius + northeast.y
        
        square4.center.x = sin(-t) * radius + southeast.x
        square4.center.y = cos(-t) * radius + southeast.y
        
    }
}





