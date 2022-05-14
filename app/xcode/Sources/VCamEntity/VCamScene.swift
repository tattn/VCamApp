//
//  VCamScene.swift
//  VCam
//
//  Created by Tatsuya Tanaka on 2022/05/01.
//

import Foundation

public struct VCamScene: Codable, Identifiable {
    public init(id: Int32, name: String, objects: [VCamScene.Object]) {
        self.id = id
        self.name = name
        self.objects = objects
    }

    public let id: Int32
    public var name: String
    public var objects: [Object]
}

public extension VCamScene {
    struct Object: Codable, Identifiable {
        public init(id: Int32, name: String, type: VCamScene.ObjectType) {
            self.id = id
            self.name = name
            self.type = type
        }

        public let id: Int32
        public var name: String
        public let type: ObjectType
    }

    enum ObjectType: Codable {
        case avatar(state: Solid)
        case image(id: String, state: Plane)
        case captureDevice(id: String, state: RenderTexture)
        case wind(state: Solid)
    }

    struct Vector: Codable, Equatable {
        public init(vector: SIMD3<Float>) {
            x = vector.x
            y = vector.y
            z = vector.z
        }
        
        public var x, y, z: Float

        public static let zero = Vector(vector: .zero)

        public var simd3: SIMD3<Float> {
            .init(x: x, y: y, z: z)
        }
    }

    struct Solid: Codable, Equatable {
        public init(position: Vector, rotation: Vector) {
            self.position = position
            self.rotation = rotation
        }

        public var position: Vector
        public var rotation: Vector

        public static let zero = Solid(position: .zero, rotation: .zero)
    }

    struct Plane: Codable {
        public init(x: Float, y: Float, width: Float, height: Float) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }

        public init(rect: CGRect) {
            self.x = Float(rect.minX)
            self.y = Float(rect.minY)
            self.width = Float(rect.width)
            self.height = Float(rect.height)
        }

        public var x: Float      // 0...1
        public var y: Float      // 0...1
        public var width: Float  // 0...1
        public var height: Float // 0...1

        public var rect: CGRect {
            .init(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
        }
    }

    struct RenderTexture: Codable {
        public init(width: Float, height: Float, region: VCamScene.Plane, crop: VCamScene.Plane) {
            self.width = width
            self.height = height
            self.region = region
            self.crop = crop
        }

        public var width: Float  // number of horizontal pixels of the rendertexture
        public var height: Float // number of vertical pixels of the rendertexture
        public var region: Plane
        public var crop: Plane
    }
}
