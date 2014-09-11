//
//  CameraViewController.swift
//  ElevenChat
//
//  Created by Anna Carey on 9/11/14.
//  Copyright (c) 2014 Anna Carey. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController : UIViewController {
  @IBOutlet var cameraView: UIView!
  // Our global session
  private let captureSession = AVCaptureSession()
  //The camera, if found
  private var captureDevice : AVCaptureDevice?
  //which camera are we using
  private var cameraPosition = AVCaptureDevicePosition.Back
  //jpeg output
  private var stillImageOutput : AVCaptureStillImageOutput?
  //preview layer
  private var previewLayer : AVCaptureVideoPreviewLayer?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    if findCamera(cameraPosition){
      //start session
      beginSession()
    }else{
      
    }
  }
  
  
  
  func findCamera(position : AVCaptureDevicePosition) -> Bool{
    //grab all the video capture devices
    let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
    
    //find the camera at the matching position
    for device in devices {
      if device.position == position {
        captureDevice = device as? AVCaptureDevice
      }
    }
    return captureDevice != nil
  }
  
  func beginSession() {
    var err : NSError? = nil
    
//    AVCaptureDeviceInput(device: <#AVCaptureDevice!#>, error: <#NSErrorPointer#>)
    let videoCapture = AVCaptureDeviceInput(device: captureDevice, error: &err)
    if err != nil {
      println("Couldn't start ession : \(err?.description)")
      return
    }
    
    if captureSession.canAddInput(videoCapture) {
      captureSession.addInput(videoCapture)
    }
    
    if !captureSession.running{
      //setup jpeg output
      stillImageOutput = AVCaptureStillImageOutput()
      let outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG  ]
      stillImageOutput!.outputSettings = outputSettings
      
      //add output to session
      if captureSession.canAddOutput(stillImageOutput){
        captureSession.addOutput(stillImageOutput)
      }
    }
    
    //display in UI
    previewLayer  = AVCaptureVideoPreviewLayer(session: captureSession)
    
    cameraView.layer.addSublayer(previewLayer)
    previewLayer?.frame  = cameraView.layer.frame
    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    captureSession.startRunning()
  }
  
}

