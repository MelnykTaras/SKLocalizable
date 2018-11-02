//
//  String+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import Foundation

public extension String {
    
    /// Get self as key and return related localized value
    ///
    /// - Parameter tableName: .strings file name
    /// - Parameter bundle: language bundle, from where should be taken value. Default is Bundle.localiztion
    /// - Parameter arguments: JSON, where:
    ///     - key - is parameter key in localized string value from .strings file
    ///     - value - value, which will be used for replacing key in localized string. Should conforms to [String convertible](https://developer.apple.com/documentation/swift/string/2427941-init)
    /// - Returns: localized value if found. Key (self) otherwise
    public func localized(tableName: String? = nil, bundle: Bundle = .localization, arguments: Dictionary<String, Any>? = nil) -> String {
        
        var localizedValue = NSLocalizedString("\(self)", tableName: tableName, bundle: bundle, comment: "") // Wrapped self into string for localization export support
        
        if let arguments = arguments {
            for key in arguments.keys {
                guard let value = arguments[key] else { continue }
                let valueString = String.init(describing: value)
                
                localizedValue = localizedValue.replacingOccurrences(of: "$(\(key))", with: valueString)
            }
        }
        
        return localizedValue
    }
    
    /// Load formatted string value from tableName.stringsDict and paste arguments at corresponding places in format string
    ///
    /// - Parameter tableName: .strings file name
    /// - Parameter arguments: set of parameters, which should be use for plural replacement
    /// Example: "Date.UnitPlural.Hour" key -> "%d hour" value for argument "1" -> put argument at "%d" place -> returns "1 hour" result string
    public func localizedPlural(tableName: String? = nil, arguments: CVarArg...) -> String {
        return String.localizedStringWithFormat(self.localized(tableName: tableName), arguments)
    }
}
