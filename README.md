
# UnifiedToast
UnifiedToast is a lightweight and customizable toast library for iOS that works with both UIKit and SwiftUI.


## Installation

### Swift Package Manager

You can install UnifiedToast using Swift Package Manager. In Xcode, go to `File > Swift Packages > Add Package Dependency` and enter the URL for this repository: https://github.com/aarons2222/UnifiedToast

### Manual

Alternatively, you can also add the `UnifiedToast.swift` file to your Xcode project manually.



## With SwiftUI 

```SwiftUI
struct ContentView: View {
    @State var toast: UnifiedToast? = nil
      var body: some View {
          VStack {
              Button {
                  toast = UnifiedToast(type: .error, title: "Error", message: "Check connection")
              } label: {
                  Text("Run")
              }

          }
          .toastView(toast: $toast)
      }
}

```








## With UIKit 

```UIKit
import UIKit
import UnifiedToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        UnifiedToastManager.showUnifiedToast(type: .warning, title: "Success", message: "Operation completed successfully", in: self)

    }
}

```





