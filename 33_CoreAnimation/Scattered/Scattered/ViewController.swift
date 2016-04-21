//
//  ViewController.swift
//  Scattered
//
//  Created by Jason Zheng on 4/21/16.
//  Copyright © 2016 Jason Zheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  var textLayer: CATextLayer!
  var text: String? {
    didSet {
      let font = NSFont.systemFontOfSize(textLayer.fontSize)
      let attributes = [NSFontAttributeName: font]
      var size = text?.sizeWithAttributes(attributes) ?? CGSize.zero
      size.width = ceil(size.width)
      size.height = ceil(size.height)
      textLayer.bounds = NSRect(origin: CGPoint.zero, size: size)
      textLayer.superlayer?.bounds = NSRect(x: 0, y: 0, width: size.width + 20, height: size.height + 16)
      textLayer.string = text
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the view to be layer-hosting
    view.layer = CALayer()
    view.wantsLayer = true
    
    let textContainer = CALayer()
    textContainer.anchorPoint = CGPoint.zero
    textContainer.position = CGPointMake(10, 10)
    textContainer.zPosition = 100
    textContainer.backgroundColor = NSColor.blueColor().CGColor
    textContainer.borderColor = NSColor.whiteColor().CGColor
    textContainer.borderWidth = 2
    textContainer.cornerRadius = 15
    textContainer.shadowOpacity = 0.5
    view.layer!.addSublayer(textContainer)
    
    let textLayer = CATextLayer()
    textLayer.anchorPoint = CGPoint.zero
    textLayer.position = CGPointMake(10, 6)
    textLayer.zPosition = 100
    textLayer.fontSize = 24
    textLayer.foregroundColor = NSColor.whiteColor().CGColor
    
    self.textLayer = textLayer
    textContainer.addSublayer(textLayer)
    
    // Reply on text's didSet to update textLayer's bounds
    text = "Loading..."
  }
  
  @IBAction func loadImages(sender: NSButton) {
    let url = NSURL(fileURLWithPath: "/Library/Desktop Pictures")
    addImagesFromFolderURL(url)
  }

  func addImagesFromFolderURL(folderURL: NSURL) {
    let t0 = NSDate.timeIntervalSinceReferenceDate()
    var allowedFiles = 10
    let fileManager = NSFileManager()
    let enumerator = fileManager.enumeratorAtURL(folderURL, includingPropertiesForKeys: nil,
      options: NSDirectoryEnumerationOptions.SkipsSubdirectoryDescendants, errorHandler: nil)
    while let url = enumerator?.nextObject() as? NSURL {
      var isDirectory: AnyObject?
      do {
        try url.getResourceValue(&isDirectory, forKey: NSURLIsDirectoryKey)
        
        if let isDirectory = isDirectory as? NSNumber where isDirectory.boolValue == false {
          
          if let image = NSImage(contentsOfURL: url) {
            allowedFiles -= 1
            if allowedFiles < 0 {
              break
            }
            
            let thumbImage = thumbImageFromImage(image)
            presentImage(thumbImage)
            
            let t1 = NSDate.timeIntervalSinceReferenceDate()
            let interval = t1 - t0
            text = String(format: "%0.1fs", interval)
          }
        }
      } catch {
        
      }
    }
  }
  
  func thumbImageFromImage(image: NSImage) -> NSImage {
    let targetHeight: CGFloat = 100
    let imageSize = image.size
    let smallerImageSize = NSSize(width: imageSize.width * targetHeight / imageSize.height, height: targetHeight)
    let smallerImage = NSImage(size: smallerImageSize, flipped: false) { rect -> Bool in
      image.drawInRect(rect)
      return true
    }
    return smallerImage
  }
  
  func presentImage(image: NSImage) {
    let superlayerBounds = view.layer!.bounds
    
    let center = CGPoint(x: superlayerBounds.midX, y: superlayerBounds.midY)
    
    let imageBounds = CGRect(origin: CGPoint.zero, size: image.size)
    
    let randomPoint =
      CGPoint(x: CGFloat(arc4random_uniform(UInt32(superlayerBounds.maxX))),
              y: CGFloat(arc4random_uniform(UInt32(superlayerBounds.maxY))))
    
    let timingFunction
      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    let positionAnimation = CABasicAnimation()
    positionAnimation.fromValue = NSValue(point: center)
    positionAnimation.duration = 1.5
    positionAnimation.timingFunction = timingFunction
    
    let boundsAnimation = CABasicAnimation()
    boundsAnimation.fromValue = NSValue(rect: CGRect.zero)
    boundsAnimation.duration = 1.5
    boundsAnimation.timingFunction = timingFunction
    
    let layer = CALayer()
    layer.contents = image
    layer.actions =
      ["position" : positionAnimation,
       "bounds"   : boundsAnimation]
    
    CATransaction.begin()
    view.layer!.addSublayer(layer)
    layer.position = randomPoint
    layer.bounds = imageBounds
    CATransaction.commit()
  }
}

