# UnifiedToast

UnifiedToast is a lightweight and customizable toast library for iOS that works with both UIKit and SwiftUI.

## Installation

### Swift Package Manager

You can install UnifiedToast using Swift Package Manager. In Xcode, go to `File > Swift Packages > Add Package Dependency` and enter the URL for this repository: https://github.com/aarons2222/UnifiedToast


`import SwiftUI
import UnifiedToast

struct ContentView: View {
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Button("Show Toast") {
                self.showToast = true
            }
        }
        .toast(isPresented: $showToast, title: "Hello", message: "This is a toast message!", duration: 2.0)
    }
}`
