//
//  Bunle+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import Foundation

public extension Bundle {
    
    /// Get Bundle for passed language code (ex: "en", "es", "zh" etc).
    ///
    /// Returns nil if there is no bundle for this language.
    ///
    /// Example: Bundle.init(languageCode: "en")
    public convenience init?(languageCode: String) {
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") else { return nil }
        
        self.init(path: bundlePath)
    }
    
    /// Global static bundle, used during localization
    public static var localization = Bundle.main {
        didSet {
            NotificationCenter.default.post(name: .languageChanged, object: nil)
        }
    }
}

public extension Notification.Name {
    
    static let languageChanged = Notification.Name("Localization.Language.Changed")
}
