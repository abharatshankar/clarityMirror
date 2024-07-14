import UIKit
import Flutter
import SkinCareWidget


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var flutterMethodChannel: FlutterMethodChannel?
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
         if let registrar = registrar(forPlugin: "ControlView") {
             let controller = window.rootViewController as! FlutterViewController
             flutterMethodChannel = FlutterMethodChannel(name: "com.example.clarity_mirror/mirror_channel",
                                                             binaryMessenger: controller.binaryMessenger)
                 
             let customViewFactory = CustomViewFactory(messenger: controller.binaryMessenger)
            print("--- - ---- -")
             registrar.register(customViewFactory, withId: "custom_view")
         } else {
             print("no custom ")
//             GeneratedPluginRegistrant.register(withRegistry: self)
             print("Error: FlutterPluginRegistrar is nil")
         }

        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    

    public func callFlutterFunction(message: String) {
        flutterMethodChannel?.invokeMethod("onCaptureSuccess", arguments: message, result: { (result: Any?) in
          if let result = result as? String {
            print("Received result from Flutter: \(result)")
          } else {
            print("No result from Flutter")
          }
        })
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
