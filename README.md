
# UnifiedToast
UnifiedToast is a lightweight and customizable toast library for iOS that works with both UIKit and SwiftUI.


## Installation

### Swift Package Manager

You can install UnifiedToast using Swift Package Manager. In Xcode, go to `File > Swift Packages > Add Package Dependency` and enter the URL for this repository: https://github.com/aarons2222/UnifiedToast

### Manual

Alternatively, you can also add the `UnifiedToast.swift` file to your Xcode project manually.



## With SwiftUI 

```SwiftUI
import SwiftUI
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





