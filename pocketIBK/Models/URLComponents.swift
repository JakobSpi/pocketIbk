//
//  URLComponents.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 12.05.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import UIKit
struct URLComponents {
    // MARK: - Properties
    let resolutionWidth: CGFloat
    let resolutionHeight: CGFloat
    let backgroundColor: String
    let foregroundColor: String
    let movieText: String
    // MARK: - Functions
    func getEscapedUrl() -> String {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!§$%&/()=?`¡“¶¢[]|{}≠¿ -.,;:_").inverted)
        let escapedTextForUrl = movieText.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        return "https://dummyimage.com/\(resolutionWidth)x\(resolutionHeight)/\(backgroundColor)/\(foregroundColor).png?text=\(escapedTextForUrl!)"
    }
}
