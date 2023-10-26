import SwiftUI

struct TrailingImageLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}
