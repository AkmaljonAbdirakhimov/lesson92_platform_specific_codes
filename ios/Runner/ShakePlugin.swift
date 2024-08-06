
import Flutter
import UIKit

@objc public class ShakePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    // Silkitish hodisalarini Flutter-ga yuborish uchun ishlatiladi
    private var eventSink: FlutterEventSink?
    
    // Plugin-ni ro'yxatdan o'tkazish uchun Flutter chaqiradigan metod
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "uz.najottalim.platform/shake", binaryMessenger: registrar.messenger())
        let instance = ShakePlugin()
        channel.setStreamHandler(instance)
    }
    
    // Flutter tomonidan stream tinglashni boshlash uchun chaqiriladi
    @objc public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        // Silkitish hodisalarini kuzatish uchun NotificationCenter-ga obuna bo'lamiz
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidShake), name: .deviceDidShake, object: nil)
        return nil
    }
    
    // Flutter tomonidan stream tinglashni to'xtatish uchun chaqiriladi
    @objc public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // NotificationCenter-dan obunani bekor qilamiz va eventSink-ni tozalaymiz
        NotificationCenter.default.removeObserver(self)
        eventSink = nil
        return nil
    }
    
    // Qurilma silkitilganda chaqiriladigan metod
    @objc func deviceDidShake() {
        // Silkitish hodisasini Flutter-ga yuboramiz
        eventSink?("shake")
    }
}

// Silkitish hodisasi uchun maxsus notification nomi
extension NSNotification.Name {
    public static let deviceDidShake = NSNotification.Name("DeviceDidShake")
}

// UIWindow-ga silkitishni aniqlash imkoniyatini qo'shamiz
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        guard motion == .motionShake else { return }
        // Silkitish aniqlanganda notification yuboramiz
        NotificationCenter.default.post(name: .deviceDidShake, object: nil)
    }
}
