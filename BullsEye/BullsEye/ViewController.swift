//
//  ViewController.swift
//  BullsEye
//
//  Created by Ahmed Elbasha on 11/8/17.
//  Copyright © 2017 Ahmed Elbasha. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue = 0;
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()

        // Customize the visualization of the slider.

        // Set Image for thumb in normal state.
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)

        // Set Image for thumb in highlighted state.
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        //Create UIEdgeInsets For the left and the right sides of the thumb.
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

        // Create, Resize and Set Image for the left side of the thumb.
        let trackLeftImage =  #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)

        // Create, Resize and Set Image for the right side of the thumb.
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
//        var difference : Int
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        } else if targetValue > currentValue {
//            difference = targetValue - currentValue
//        } else {
//            difference = 0
//        }

//        var difference = currentValue - targetValue
//        if difference < 0 {
//            difference = difference * -1
//        }

        // returns the diference of currentValue subtracted of targetValue.
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference

        let title : String
        
        // giving bonus based on player's score.
        if difference == 0 {
            title = "Perfect"
            points += 100
        }else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        }else if difference < 10 {
            title = "Pretty Good!"
        }else {
            title = "Not even close..."
        }

        // Added the gained points in round to the overall score.
        score += points

        // Updates the message text with the points value.
        let message = "You scored \(points) points."

        // creates an UIAlertController to inform user to tell the user if he reached the goal or not.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        // assigns the current value of slider to currentValue.
        currentValue = lroundf(slider.value)
    }

    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()

        // Adding CATransition animation to show the last score of previous player.
        
        // Adding Crossfade Animation.

        // Instantiate CATransition Object.
        let transition = CATransition()

        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        view.layer.add(transition, forKey: nil)
    }
}

