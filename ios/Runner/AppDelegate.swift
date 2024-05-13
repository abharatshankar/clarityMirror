import UIKit
import Flutter
import SkinCareWidget


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
         if let registrar = registrar(forPlugin: "ControlView") {
             let controller = window.rootViewController as! FlutterViewController
             let customViewFactory = CustomViewFactory(messenger: controller.binaryMessenger)
            
            registrar.register(customViewFactory, withId: "custom_view")
         } else {
             print("no custom ")
//             GeneratedPluginRegistrant.register(withRegistry: self)
             print("Error: FlutterPluginRegistrar is nil")
         }

        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    

}


public class CustomViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return CustomViewController(withFrame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger,flutterEngine: FlutterEngine())
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
