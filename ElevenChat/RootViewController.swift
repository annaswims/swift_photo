//
//  ViewController.swift
//  ElevenChat
//
//  Created by Anna Carey on 9/10/14.
//  Copyright (c) 2014 Anna Carey. All rights reserved.
//

import UIKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource {
  
  var redViewController : RedViewCotroller!
  var cameraViewController :  CameraViewController!
  var greenViewController : GreenViewCotroller!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = self
  
    self.redViewController   = self.storyboard?.instantiateViewControllerWithIdentifier("redViewController") as? RedViewCotroller
    self.cameraViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("cameraViewController") as? CameraViewController
    self.greenViewController = self.storyboard?.instantiateViewControllerWithIdentifier("greenViewController") as? GreenViewCotroller
    
    var startingViewControllers : NSArray = [self.cameraViewController]
    
    self.setViewControllers(startingViewControllers, direction: .Forward, animated: false, completion: nil)
    
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    switch viewController.title! {
    case "Red":
      return nil
    case "Camera":
      return redViewController
    case "Green":
      return cameraViewController
    default:
      return nil
    }
    
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    switch viewController.title! {
    case "Red":
      return cameraViewController
    case "Camera":
      return greenViewController
    case "Green":
      return nil
    default:
      return nil
    }
    
  }
  
}