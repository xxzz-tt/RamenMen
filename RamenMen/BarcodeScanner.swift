import SwiftUI
import CodeScanner
import AVFoundation

extension CodeScannerView {
    public func torchLight(isOn: Bool) -> CodeScannerView {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: configuration.isPressed ? .leading : .trailing, endPoint: configuration.isPressed ? .trailing : .leading))
            .cornerRadius(15.0)
    }
}

struct TextOverlay: View {
    var body: some View {
        ZStack {
            Text("No Ramen found")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(6)
    }
}

struct BarcodeScanner: View {
//    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState
    @Binding var showScanner: Bool
    @State var barcodeValue = ""
    @Binding var ramen: Ramen?
    @Binding var showRamenProfile: Bool
    @State var torchIsOn = false
    @Binding var alert: Bool
    var ramenCatalog = RamenCatalog()

    func findRamen(barcode: String) {
        if let ramenID = ramenCatalog.ramenID(forKey: barcode) {
            self.ramen = authState.getRamenByName(id: ramenID)
            self.showScanner.toggle()
        } else {
            self.alert.toggle()
        }
    }
    var body: some View {
        VStack{
            HStack {
                Button(action: {self.showScanner.toggle()}) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.black)
                }.padding([.leading, .top])
                Spacer()
            }
            
            CodeScannerView(codeTypes: [.qr, .code128, .code39, .code93, .code39Mod43, .ean8, .ean13], simulatedData: "8801073113428") { result in
                switch result {
                case .success(let code):
                    print("Found code: \(code)")
                    self.barcodeValue = code
                    self.findRamen(barcode: code)
                    self.showRamenProfile.toggle()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.torchLight(isOn: self.torchIsOn)
            
            Spacer()
            
//            Text(barcodeValue)
            
            Button(action: {
                self.torchIsOn.toggle()
            }) {
                Image(systemName: self.torchIsOn ? "lightbulb.fill" : "lightbulb").resizable().frame(width: 32.0, height: 42.0)
                }.padding()
                .buttonStyle(GradientButtonStyle())
            
            Spacer()
            
        }.overlay((self.alert) ?
            AnyView(
            TextOverlay().onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.alert.toggle()
                }
                }
            ) : AnyView(EmptyView()))
    }
}

struct BarcodeScanner_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScanner(showScanner: .constant(true), ramen: .constant(Ramen()), showRamenProfile: .constant(false), alert: .constant(true)).previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max")).environmentObject(AuthenticationState.shared)
    }
}
