//
//  UIImage+.swift
//  XOXO
//
//  Created by Daniella Onishi on 03/10/21.
//

import Foundation
import UIKit

extension UIImage {
    func convertImageToBase64String() -> String {
        return jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
}
