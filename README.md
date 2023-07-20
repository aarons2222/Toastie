
# Toastie
Toastie is a lightweight and customizable toast library for iOS that works with both UIKit and SwiftUI.


## Installation

### Swift Package Manager

You can install Toastie using Swift Package Manager. In Xcode, go to `File > Swift Packages > Add Package Dependency` and enter the URL for this repository: https://github.com/aarons2222/Toastie

### Manual

Alternatively, you can also add the `Toastie.swift` file to your Xcode project manually.



## With SwiftUI 

```SwiftUI

import SwiftUI
import Toastie

struct ContentView: View {
    @State var toast: Toastie? = nil
      var body: some View {
          VStack {
              Button {
                  toast = Toastie(type: .error, title: "Error", message: "Check connection")
              } label: {
                  Text("Run")
              }

          }
          .toastieView(toast: $toast)
      }
}

```








## With UIKit 

```UIKit
import UIKit
import Toastie

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        ToastieManager.showToastie(type: .warning, title: "Success", message: "Operation completed successfully", in: self)

    }
}

```





