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
    let videoCapture = AVCaptureDeviceInput(device: captureDevice, error: &err)
    
    if err != nil {
      println("Couldn't start ession : \(err?.description)")
      return
    }
    
    if captureSession.canAddInput(videoCapture) {
      captureSession.addInput(videoCapture)
    }
    
    if !captureSession.running {
      //setup jpeg output
      stillImageOutput = AVCaptureStillImageOutput()
      let outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
      stillImageOutput!.outputSettings = outputSettings
      
      //add output to session
      if captureSession.canAddOutput(stillImageOutput){
        captureSession.addOutput(stillImageOutput)
      }
      
      
      //display in UI
      previewLayer  = AVCaptureVideoPreviewLayer(session: captureSession)
      
      cameraView.layer.addSublayer(previewLayer)
      previewLayer?.frame  = cameraView.layer.frame
      previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
      
      captureSession.startRunning()
    }
  }
  
  @IBAction func flipCamera(sender: UIButton) {
    //Flip the camera...
    //When Session is running to make change you must...
    captureSession.beginConfiguration()
    let currentInput = captureSession.inputs[0] as AVCaptureInput
    captureSession.removeInput(currentInput)
    
    //toggle the camera...
    cameraPosition = cameraPosition == .Back ? .Front : .Back
    
    //find other camera..
    if findCamera(cameraPosition){
      beginSession()
    }else{
      //show sad panda
    }
    
    captureSession.commitConfiguration()
  }
  
  @IBAction func takePhoto(sender: UIButton) {
    if let stillOutput = self.stillImageOutput {
      // we do this on another thread so that we don't hang the UI
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        //find the video connection
        var videoConnection : AVCaptureConnection?
        for connecton in stillOutput.connections {
          //find a matching input port
          for port in connecton.inputPorts!{
            if port.mediaType == AVMediaTypeVideo {
              videoConnection = connecton as? AVCaptureConnection
              break //for port
            }
          }
          
          if videoConnection  != nil {
            break// for connections
          }
        }
        if videoConnection  != nil {
          stillOutput.captureStillImageAsynchronouslyFromConnection(videoConnection){
            (imageSampleBuffer : CMSampleBuffer!, _) in
            
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
            self.didTakePhoto(imageData)
          }
        }
      }
    }
  }
  
  
  func didTakePhoto(imageData: NSData){
    //Example 1: if you wante to show a thumbnail in the UI
    let images = UIImage(data: imageData)
    
    // if you want to save the image to  a file...
    var formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
    let prefix: String = formatter.stringFromDate(NSDate())
    let fileName = "\(prefix).jpg"
    let tmpDirectory = NSTemporaryDirectory()
    let snapFileName = tmpDirectory.stringByAppendingPathComponent(fileName)
    imageData.writeToFile(snapFileName, atomically: true)
  
    
  }
  
  
}

