//
//  WordMasterViewController.swift
//  ELL App
//
//  Created by Genton Mo on 2/18/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class WordMasterViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    var newButton: UIButton?
    let commentBox = UITextField()
    var objectId = String()
    var query = PFQuery(className: "Book")
    let radioButtonController = SSRadioButtonsController()
    var selectedButtons = [UIButton]()
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        let centerX = Int(self.view.center.x)
        
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            
            let arr = object!["words"] as! [String]
            let getRandom = self.randomSequenceGenerator(0, max: arr.count - 1)
            
            for _ in 0...arr.count - 1 {
                if i < 8 {
                    self.makeButton(arr[getRandom()], buttonNum: i++)
                }
            }
            
            self.newButton = UIButton(type: UIButtonType.System)
            self.newButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.newButton!.addTarget(self, action: "submit:", forControlEvents: UIControlEvents.TouchUpInside)
            self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
            self.newButton!.center = CGPoint(x: centerX, y: 373 + (i + 1) / 2 * 85)
            self.newButton!.setTitle("SUBMIT", forState: UIControlState.Normal)
            self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(15, weight: UIFontWeightHeavy)
            self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
            self.view.addSubview(self.newButton!)
        }
    }
    
    func makeButton(word: String, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 373 + buttonNum / 2 * 85)
        self.newButton!.setTitle(word, forState: UIControlState.Normal)
        self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)
        self.newButton!.selected = false
        self.newButton!.backgroundColor = UIColor.clearColor()
        self.radioButtonController.addButton(self.newButton!)
        self.view.addSubview(self.newButton!)
    }
    
    func pressed(sender: UIButton) {
        
        if sender.backgroundColor == UIColor.clearColor() {
            
            if selectedButtons.count < 1 {
                sender.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
                selectedButtons.insert(sender, atIndex: 0)
            }
        }
            
        else {
            removeButtonFromArray(sender)
            sender.backgroundColor = UIColor.clearColor()
        }
    }
    
    func submit(sender: UIButton) {
        
        if selectedButtons.count == 1 {
            words.append(selectedButtons[0].currentTitle!)
            
            for button in selectedButtons {
                button.backgroundColor = UIColor.clearColor()
            }
            
            commentBox.text = ""
            
            selectedButtons.removeAll()
        }
    }
    
    func removeButtonFromArray(toRemove: UIButton) {
        
        if selectedButtons[0].currentTitle == toRemove.currentTitle {
            
            if selectedButtons.count == 1 {
                selectedButtons.removeAll()
            }
                
            else {
                selectedButtons[0] = selectedButtons[1]
                selectedButtons.removeLast()
            }
        }
            
        else {
            selectedButtons.removeLast()
        }
    }
    
    func randomSequenceGenerator(min: Int, max: Int) -> () -> Int {
        var numbers: [Int] = []
        return {
            if numbers.count == 0 {
                numbers = Array(min ... max)
            }
            
            let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.removeAtIndex(index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        performSegueWithIdentifier("vieworder", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "vieworder" {
            let vc = segue.destinationViewController as! WordMasterTableViewController
            vc.words = words
        }
        
    }
    
    
}