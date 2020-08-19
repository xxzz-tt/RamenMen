import SwiftUI

struct ScanButton: View {
//    @EnvironmentObject var env: Environment
    @EnvironmentObject var authState: AuthenticationState
    @State var showScanner = false
    @State var ramenID = ""
    @Binding var showRamenProfile: Bool
    @Binding var ramen: Ramen?
    @State var alert = false
    var body: some View {
        ZStack {
            VStack {
//                Text(String(self.alert))
               Button(action: {
                   self.showScanner.toggle()
               }) {
                   Image(systemName: "viewfinder").resizable().frame(width: 20.0, height: 20.0)
                       .foregroundColor(Color.black)
               }.padding([.trailing], 15.0)
                   .sheet(isPresented: self.$showScanner) {
                    BarcodeScanner(showScanner: self.$showScanner, ramen: self.$ramen, showRamenProfile: self.$showRamenProfile, alert: self.$alert).environmentObject(self.authState)
               }
           }
//            if(showRamenProfile && ramen != nil) {
////                if (ramen != nil) {
//                    AnyView(RamenProfile(ramen: ramen!, showRamenProfile: self.$showRamenProfile))
////                } else {
////                    AnyView(
////                        EmptyView()
////                    )
////                }
//            }
        }
//        .alert(isPresented: $alert) {
//            Alert(title: Text("Ramen Not Found"), message: Text(""), dismissButton: .default(Text("dismiss")))
//        }
    }
}

struct ScanButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanButton(showRamenProfile: .constant(false), ramen: .constant(Ramen())).environmentObject(AuthenticationState.shared)
    }
}
