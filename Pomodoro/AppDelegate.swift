import UIKit

extension Notification.Name {
    static let applicationWillEnterForeground = Notification.Name("applicationWillEnterForeground")
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Seu código de inicialização aqui
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // O aplicativo foi minimizado
        print("O aplicativo foi minimizado.")
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // O aplicativo está prestes a entrar em primeiro plano (voltando de um estado minimizado)
        print("O aplicativo está prestes a entrar em primeiro plano.")
        
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // O aplicativo será fechado
        print("O aplicativo será fechado.")
        
    
    }
}
