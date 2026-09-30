import AppKit
import SwiftUI
import XCTest
@testable import PokeTokenBar

final class PokemonTypeColorTests: XCTestCase {
    private func hex(_ color: Color) -> UInt32? {
        guard let c = NSColor(color).usingColorSpace(.sRGB) else { return nil }
        let r = UInt32((c.redComponent * 255).rounded())
        let g = UInt32((c.greenComponent * 255).rounded())
        let b = UInt32((c.blueComponent * 255).rounded())
        return (r << 16) | (g << 8) | b
    }

    func testKnownTypesUseClassicTypeChartColors() {
        XCTAssertEqual(hex(pokemonTypeColor("fire")), 0xFF4422)
        XCTAssertEqual(hex(pokemonTypeColor("water")), 0x3399FF)
        XCTAssertEqual(hex(pokemonTypeColor("fairy")), 0xEE99EE)
    }

    func testPaletteCoversAllEighteenMainSeriesTypes() {
        let types = ["normal", "fire", "water", "electric", "grass", "ice", "fighting", "poison", "ground",
                     "flying", "psychic", "bug", "rock", "ghost", "dragon", "dark", "steel", "fairy"]
        XCTAssertEqual(Set(pokemonTypeHex.keys), Set(types))
    }

    func testLookupIsCaseInsensitive() {
        XCTAssertEqual(hex(pokemonTypeColor("Electric")), 0xFFCC33)
        XCTAssertEqual(hex(pokemonTypeColor("GRASS")), 0x77CC55)
    }

    func testUnknownTypesFallBackToGray() {
        for type in ["stellar", "shadow", "unknown", ""] {
            XCTAssertEqual(pokemonTypeColor(type), .gray, type)
        }
    }
}
