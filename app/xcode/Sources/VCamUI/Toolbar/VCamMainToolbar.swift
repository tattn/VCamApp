//
//  VCamMainToolbar.swift
//  
//
//  Created by Tatsuya Tanaka on 2023/02/12.
//

import SwiftUI
import VCamEntity

public struct VCamMainToolbar: View {
    public init() {}

    @State private var isPhotoPopover = false
    @State private var isEmojiPickerPopover = false
    @State private var isMotionPickerPopover = false
    @State private var isBlendShapePickerPopover = false

    @Environment(\.locale) var locale
    @OpenEmojiPicker var openEmojiPicker

    public var body: some View {
        VStack(spacing: 2) {
            Item {
                isPhotoPopover.toggle()
            } label: {
                Image(systemName: "paintpalette.fill")
            }
            .popover(isPresented: $isPhotoPopover) {
                VCamPopoverContainer(L10n.background.key) {
                    VCamMainToolbarBackgroundColorPicker()
                }
                .environment(\.locale, locale)
            }

            Item {
                isEmojiPickerPopover.toggle()
            } label: {
                Text("👍")
            }
            .popover(isPresented: $isEmojiPickerPopover) {
                VCamPopoverContainerWithButton(L10n.emoji.key) {
                    Button {
                        openEmojiPicker()
                        isEmojiPickerPopover = false
                    } label: {
                        Image(systemName: "macwindow")
                    }
                    .emojiPicker(for: openEmojiPicker) { emoji in
                        Task {
                            try await VCamEmojiAction(configuration: .init(emoji: emoji))(context: .empty)
                        }
                    }
                } content: {
                    VCamMainToolbarEmojiPicker()
                }
                .environment(\.locale, locale)
                .frame(width: 240)
            }

            Item {
                isMotionPickerPopover.toggle()
            } label: {
                Image(systemName: "figure.wave")
            }
            .popover(isPresented: $isMotionPickerPopover) {
                VCamPopoverContainerWithWindow(L10n.motion.key) {
                    VCamMainToolbarMotionPicker()
                }
                .environment(\.locale, locale)
                .frame(width: 240)
            }

            Item {
                isBlendShapePickerPopover.toggle()
            } label: {
                Image(systemName: "face.smiling")
            }
            .popover(isPresented: $isBlendShapePickerPopover) {
                VCamPopoverContainerWithWindow(L10n.facialExpression.key) {
                    VCamMainToolbarBlendShapePicker()
                }
                .environment(\.locale, locale)
                .frame(width: 280, height: 150)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .background(.thinMaterial)
    }

    private struct Item<Label: View>: View {
        let action: () -> Void
        let label: () -> Label

        private let size: CGFloat = 18

        var body: some View {
            Button(action: action) {
                label()
                    .frame(width: size, height: size)
                    .macHoverEffect()
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    VCamMainToolbar()
}
