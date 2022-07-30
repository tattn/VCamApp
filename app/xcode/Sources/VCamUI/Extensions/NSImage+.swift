//
//  NSImage+.swift
//  
//
//  Created by Tatsuya Tanaka on 2022/06/13.
//

import AppKit
import CoreImage

public extension NSImage {
    var ciImage: CIImage? {
        guard let imageData = self.tiffRepresentation else { return nil }
        return CIImage(data: imageData)
    }

    func writeAsPNG(to destination: URL) throws {
        guard let tiffData = self.tiffRepresentation else {
            throw NSError(domain: "vcam", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get tiffRepresentation. url: \(destination)"])
        }
        let imageRep = NSBitmapImageRep(data: tiffData)
        guard let imageData = imageRep?.representation(using: .png, properties: [:]) else {
            throw NSError(domain: "vcam", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get PNG representation. url: \(destination)"])
        }
        try imageData.write(to: destination)
    }
}
