import L10n
import SwiftUI
import SwiftUIHelpers

public struct EmptyState: Equatable {
  public let icon: UIImage
  public let text: String
  public var message: NSAttributedString?

  public init(
    icon: UIImage,
    text: String,
    message: NSAttributedString? = nil
  ) {
    self.icon = icon
    self.text = text
    self.message = message
  }
}

public struct EmptyStateView: View {
  public init(
    emptyState: EmptyState,
    buttonAction: (() -> Void)? = nil,
    buttonText: String? = nil
  ) {
    self.emptyState = emptyState
    self.buttonAction = buttonAction
    self.buttonText = buttonText
  }

  public let emptyState: EmptyState
  public var buttonAction: (() -> Void)?
  public var buttonText: String?

  public var body: some View {
    ZStack {
      Color(.backgroundPrimary)
        .ignoresSafeArea()

      VStack(spacing: .grid(5)) {
        Image(uiImage: emptyState.icon)
          .imageScale(.large)
          .accessibilityHidden(true)

        VStack(spacing: .grid(2)) {
          Text(emptyState.text)
            .font(.titleOne)
          if let message = emptyState.message {
            Text(message)
              .multilineTextAlignment(.center)
              .font(.bodyOne)
              .foregroundColor(Color(.textSecondary))
          }
          if buttonAction != nil {
            Button(
              action: buttonAction ?? {},
              label: { Text(buttonText ?? "") }
            )
            .buttonStyle(CMButtonStyle())
            .padding(.top, .grid(4))
            .accessibilitySortPriority(1)
          }
        }
        .padding(.horizontal, .grid(4))
      }
      .accessibilityElement(children: .contain)
      .frame(maxHeight: .infinity, alignment: .center)
      .foregroundColor(Color(.textPrimary))
    }
  }
}

struct EmptyStateView_Previews: PreviewProvider {
  static var previews: some View {
    Preview {
      EmptyStateView(
        emptyState: .init(
          icon: Asset.twitterEmpty.image,
          text: "No tweets atm",
          message: .init(string: "")
        )
      )
    }
  }
}
