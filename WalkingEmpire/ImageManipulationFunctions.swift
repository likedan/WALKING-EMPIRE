
//
//  ImageManipulationFunctions.swift
//  WalkingEmpire
//
//  Created by Kedan Li on 14/12/13.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class ImageManipulationFunctions: NSObject {
   
    //Change Size of UIImage
    class func changeImageSize(image: UIImage, size: CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        var img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    //Change Alpha of UIImage
    class func changeAlpha(image: UIImage, alpha: CGFloat)->UIImage{
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        var ctx: CGContextRef = UIGraphicsGetCurrentContext()
        var area = CGRectMake(0, 0, image.size.width, image.size.height)
        
        CGContextScaleCTM(ctx, 1, -1)
        CGContextTranslateCTM(ctx, 0, -area.size.height)
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply)
        CGContextSetAlpha(ctx, alpha)
        CGContextDrawImage(ctx, area, image.CGImage)
        
        var newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
}
