//
//  ViewController.swift
//  CAAnimationDemo
//
//  Created by Apple on 4/18/18.
//  Copyright © 2018 Apple. All rights reserved.//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {
   
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
    //  print(totalBytesWritten,totalBytesExpectedToWrite)
        let percent = CGFloat(totalBytesWritten)/CGFloat(totalBytesExpectedToWrite)
        print(percent)
      //  shapeLayer.strokeEnd = percent
        DispatchQueue.main.async {
            
            self.percentLabel.text = "\(percent * 100)%"
            self.shapeLayer.strokeEnd = percent
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finsih Dowloanign")
    }
    
  let shapeLayer = CAShapeLayer()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize:32)
  
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(percentLabel)
        percentLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentLabel.center = view.center
        
       
        let center = view.center
        //create a tracklayer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2 , endAngle: 2*CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.black.cgColor
        trackLayer.lineWidth = 10
     
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(trackLayer)
   
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
   // let urlString = "https://www.wikihow.com/Download-Google-Docs#/Image:Download-Google-Docs-Step-1-Version-3.jpg"
   let urlString =  "https://rsg.mjcdn.cc/3ae0ebb3351957419b507d107c3b6ef0/CRrJwY_qS1c"
   
    
    private func begindownloadingFile(){
        print("attemp to download")
        shapeLayer.strokeEnd = 0
        let configuration = URLSessionConfiguration.default
        let queue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate:self , delegateQueue: queue)
        
        
        guard let url = URL(string: urlString) else {return}
       let downloadTask = urlSession.downloadTask(with: url)
      downloadTask.resume()
 
    }
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urBAsic")
    }
    
    @objc func handleTap(){
        print(123)
        begindownloadingFile()
        animateCircle()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

