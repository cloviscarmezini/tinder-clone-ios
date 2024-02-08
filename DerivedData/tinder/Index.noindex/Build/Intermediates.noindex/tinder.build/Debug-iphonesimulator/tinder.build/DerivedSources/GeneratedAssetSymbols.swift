import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "card-deslike" asset catalog image resource.
    static let cardDeslike = ImageResource(name: "card-deslike", bundle: resourceBundle)

    /// The "card-like" asset catalog image resource.
    static let cardLike = ImageResource(name: "card-like", bundle: resourceBundle)

    /// The "icone-chat" asset catalog image resource.
    static let iconeChat = ImageResource(name: "icone-chat", bundle: resourceBundle)

    /// The "icone-deslike" asset catalog image resource.
    static let iconeDeslike = ImageResource(name: "icone-deslike", bundle: resourceBundle)

    /// The "icone-like" asset catalog image resource.
    static let iconeLike = ImageResource(name: "icone-like", bundle: resourceBundle)

    /// The "icone-logo" asset catalog image resource.
    static let iconeLogo = ImageResource(name: "icone-logo", bundle: resourceBundle)

    /// The "icone-perfil" asset catalog image resource.
    static let iconePerfil = ImageResource(name: "icone-perfil", bundle: resourceBundle)

    /// The "icone-superlike" asset catalog image resource.
    static let iconeSuperlike = ImageResource(name: "icone-superlike", bundle: resourceBundle)

    /// The "perfil" asset catalog image resource.
    static let perfil = ImageResource(name: "perfil", bundle: resourceBundle)

    /// The "pessoa-1" asset catalog image resource.
    static let pessoa1 = ImageResource(name: "pessoa-1", bundle: resourceBundle)

    /// The "pessoa-10" asset catalog image resource.
    static let pessoa10 = ImageResource(name: "pessoa-10", bundle: resourceBundle)

    /// The "pessoa-11" asset catalog image resource.
    static let pessoa11 = ImageResource(name: "pessoa-11", bundle: resourceBundle)

    /// The "pessoa-12" asset catalog image resource.
    static let pessoa12 = ImageResource(name: "pessoa-12", bundle: resourceBundle)

    /// The "pessoa-13" asset catalog image resource.
    static let pessoa13 = ImageResource(name: "pessoa-13", bundle: resourceBundle)

    /// The "pessoa-14" asset catalog image resource.
    static let pessoa14 = ImageResource(name: "pessoa-14", bundle: resourceBundle)

    /// The "pessoa-15" asset catalog image resource.
    static let pessoa15 = ImageResource(name: "pessoa-15", bundle: resourceBundle)

    /// The "pessoa-16" asset catalog image resource.
    static let pessoa16 = ImageResource(name: "pessoa-16", bundle: resourceBundle)

    /// The "pessoa-17" asset catalog image resource.
    static let pessoa17 = ImageResource(name: "pessoa-17", bundle: resourceBundle)

    /// The "pessoa-18" asset catalog image resource.
    static let pessoa18 = ImageResource(name: "pessoa-18", bundle: resourceBundle)

    /// The "pessoa-19" asset catalog image resource.
    static let pessoa19 = ImageResource(name: "pessoa-19", bundle: resourceBundle)

    /// The "pessoa-2" asset catalog image resource.
    static let pessoa2 = ImageResource(name: "pessoa-2", bundle: resourceBundle)

    /// The "pessoa-20" asset catalog image resource.
    static let pessoa20 = ImageResource(name: "pessoa-20", bundle: resourceBundle)

    /// The "pessoa-3" asset catalog image resource.
    static let pessoa3 = ImageResource(name: "pessoa-3", bundle: resourceBundle)

    /// The "pessoa-4" asset catalog image resource.
    static let pessoa4 = ImageResource(name: "pessoa-4", bundle: resourceBundle)

    /// The "pessoa-5" asset catalog image resource.
    static let pessoa5 = ImageResource(name: "pessoa-5", bundle: resourceBundle)

    /// The "pessoa-6" asset catalog image resource.
    static let pessoa6 = ImageResource(name: "pessoa-6", bundle: resourceBundle)

    /// The "pessoa-7" asset catalog image resource.
    static let pessoa7 = ImageResource(name: "pessoa-7", bundle: resourceBundle)

    /// The "pessoa-8" asset catalog image resource.
    static let pessoa8 = ImageResource(name: "pessoa-8", bundle: resourceBundle)

    /// The "pessoa-9" asset catalog image resource.
    static let pessoa9 = ImageResource(name: "pessoa-9", bundle: resourceBundle)

}

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif