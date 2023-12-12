//
//  Extensions.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import Foundation
import UIKit

extension  UIViewController {

    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension UIView {

    func setCardView(){
        layer.cornerRadius = 15.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width:0, height: 0)
        layer.masksToBounds = true
    }
}

extension String {

    public func md5() -> String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
