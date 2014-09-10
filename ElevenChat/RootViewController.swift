//
//  ViewController.swift
//  ElevenChat
//
//  Created by Anna Carey on 9/10/14.
//  Copyright (c) 2014 Anna Carey. All rights reserved.
//

import UIKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource {
  
  var redViewController : UIViewController!
  var blueViewController : UIViewController!
  var greenViewController : UIViewController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = self
    
    self.redViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("redViewController") as? UIViewController
    self.redViewController.title = "Red"
    
    
    self.blueViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("blueViewController") as? UIViewController
    self.blueViewController.title = "Blue"
    
     self.greenViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("greenViewController") as? UIViewController
    self.greenViewController.title = "Green"
    
    var startingViewControllers : NSArray = [self.blueViewController]
    
    self.setViewControllers(startingViewControllers, direction: .Forward, animated: false, completion: nil)
    
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    switch viewController.title! {
    case "Red":
      return nil
    case "Blue":
      return redViewController
    case "Green":
      return blueViewController
    default:
      return nil
    }
    
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    switch viewController.title! {
    case "Red":
       return blueViewController
    case "Blue":
     return greenViewController
    case "Green":
      return nil
    default:
      return nil
    }
   
  }

}

