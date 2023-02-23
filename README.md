
# UnifiedToast
UnifiedToast is a lightweight and customizable toast library for iOS that works with both UIKit and SwiftUI.




## SwiftUI Usage

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








## UIKit Usage

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





