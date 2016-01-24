//
//  WordConnectViewController.swift
//  ELL App
//
//  Created by Genton Mo on 1/24/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class WordConnectViewController: UIViewController, SSRadioButtonControllerDelegate {

    var newButton: UIButton?
    let commentBox = UITextField()
    var buttons = [UIButton]()
    var objectId = String()
    var query = PFQuery(className: "Book")
    let radioButtonController = SSRadioButtonsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true

        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in

            let arr = object!["words"] as! [String]
            let centerX = Int(self.view.center.x)
            var i = 0
            
            for word in arr {
                self.newButton = UIButton()
                //self.newButton.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
                //self.newButton!.frame = CGRect(x: 170 + i % 2 * 228, y: 373 + i / 2 * 85, width: 200, height: 30)
                self.newButton!.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
                self.newButton!.center = CGPoint(x: centerX + 150 * ((i % 2 == 0) ? -1 : 1), y: 373 + i / 2 * 85)
                self.newButton!.setTitle(word, forState: UIControlState.Normal)
                
                self.radioButtonController.addButton(self.newButton!)
                self.view.addSubview(self.newButton!)
                i++;
            }
            
            self.commentBox.frame = (CGRect(x: 0, y: 0, width: 400, height: 30))
            self.commentBox.center = CGPoint(x: centerX, y: 373 + (i + 1) / 2 * 85)
            self.commentBox.placeholder = "Optional Notes"
            self.commentBox.borderStyle = UITextBorderStyle.RoundedRect
            self.view.addSubview(self.commentBox)
        }
 
    }

    func didSelectButton(aButton: UIButton?) {
       /* if aButton!.selected {
            aButton!.selected = false
            aButton!.backgroundColor = UIColor.clearColor()
        }*/
        
        //else {
            //aButton!.backgroundColor = UIColor.blueColor()
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
