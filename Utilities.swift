//
//  Utilities.swift
//  StudyBuddy
//
//  Created by Jason Snider on 11/18/25.
//
import SwiftUI

extension Color {
    public init(hex: Color.Hex) {
        switch hex {
            case .rgb(let rgb):
                self.init(rgba: (rgb << 8) | 0xFF)
            case .rgba(let rgba):
                self.init(rgba: rgba)
        }
    }

    private init(rgba: UInt32) {
        self.init(
            red: CGFloat((rgba & 0xFF00_0000) >> 24) / 255.0,
            green: CGFloat((rgba & 0x00FF_0000) >> 16) / 255.0,
            blue: CGFloat((rgba & 0x0000_FF00) >> 8) / 255.0,
            opacity: CGFloat(rgba & 0x0000_00FF) / 255.0
        )
    }

    private var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        #if canImport(UIKit)
            typealias NativeColor = UIColor
        #elseif canImport(AppKit)
            typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
    }

    public var hex: Color.Hex {
        let (r, g, b, a) = self.components

        let hexValue: UInt32 = [r, g, b, a].reduce(0) { partialResult, value in
            return (partialResult << 8) | UInt32(clamping: lroundf(Float(value) * 255))
        }

        return .rgba(hexValue)
    }
}

extension Color {
    public var luminance: Int {
        let (r, g, b, _) = components
        return Int((21.26 * r) + (71.52 * g) + (7.22 * b))
    }

    public var overlayedTextColor: Color {
        luminance > 50 ? .black : .white
    }

    public var complementaryColor: Color {
        let (rf, gf, bf, a) = components
        let (r, g, b) = (rf * 255, gf * 255, bf * 255)
        return Color(red: (255 - r) / 255, green: (255 - g) / 255, blue: (255 - b) / 255, opacity: a)
    }
}

extension Color {

    @available(iOS 14, macOS 11, *)
    public enum Hex: Codable {
        case rgb(UInt32)
        case rgba(UInt32)

        public var value: UInt32 {
            switch self {
                case .rgb(let value), .rgba(let value): return value
            }
        }

        public func asRGB() -> Self {
            switch self {
                case .rgb: return self
                case .rgba(let value): return .rgb(value >> 8)
            }
        }

        public func asRGBA() -> Self {
            switch self {
                case .rgb(let value): return .rgba(value << 8 | 0xFF)
                case .rgba: return self
            }
        }
    }
}

extension Color.Hex: Equatable, Hashable {
    static var random: Color.Hex { self.rgb(UInt32.random(in: 0x000000...0xFFFFFF)) }
}

extension Color.Hex: RawRepresentable {
    public typealias RawValue = Int

    public init?(rawValue: Int) {
        self = .rgba(UInt32(rawValue))
    }

    public var rawValue: Int {
        Int(self.asRGBA().value)
    }
}

extension Binding<Color.Hex> {
    func asColorBinding() -> Binding<Color> {
        Binding<Color>(
            get: { Color(hex: self.wrappedValue) },
            set: { self.wrappedValue = $0.hex }
        )
    }
}
