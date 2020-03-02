///
///  Configuration.swift
///
/// Desctiption:
///  Enum to retrieve information from the bundle info.plist.
///
/// Sample:
///
/// ```
///      struct AppConfigurationImpl: AppConfiguration {
///      var bundleIdentifier: String {
///            return try! Configuration.value(for: "CFBundleIdentifier")
///      }
///
///      var appName: String {
///            return try! Configuration.value(for: "Application name")
///      }
///
///      var executable: String {
///            return try! Configuration.value(for: "CFBundleExecutable")
///      }
///
///      var bundleDisplayName: String {
///            return try! Configuration.value(for: "CFBundleDisplayName")
///      }
///
///      var bundleVersion: String {
///            return try! Configuration.value(for: "CFBundleVersion")
///      }
///
///      var bundleShortVersionString: String {
///          return try! Configuration.value(for: "CFBundleShortVersionString")
///      }
///  }
/// ```
///
///
///
///  Created by Pavel Gnatyuk on 18/01/2020.
///

import Foundation

public enum Configuration {
    public enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    public static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
