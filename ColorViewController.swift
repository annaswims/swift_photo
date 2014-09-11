//
//  GreenViewController.swift
//  ElevenChat
//
//  Created by Anna Carey on 9/10/14.
//  Copyright (c) 2014 Anna Carey. All rights reserved.
//

import UIKit

class ColorViewCotroller :  UIViewController{
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    println(self.title)
  }
}

class GreenViewCotroller :  ColorViewCotroller {
}

//class BlueViewCotroller :  ColorViewCotroller{
//
//}

class RedViewCotroller :  ColorViewCotroller {
  
}