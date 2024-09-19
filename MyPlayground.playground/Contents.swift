protocol Analytics {
    func setAnalyticsParam(_ eventName: String, _  data: [String:Any])
}

class GoogleAnlytics : Analytics {
    static let shared = GoogleAnlytics()
    func setAnalyticsParam(_ eventName: String, _  data: [String:Any]) {
        
    }
}
 
class BackendAnlytics: Analytics {
   static let shared = BackendAnlytics()
    func setAnalyticsParam(_ eventName: String, _  data: [String:Any]) {
    }
}




//


class FactoryAnlytics: Analytics {
    var anlytics : Analytics
    
    init(_ anlytics: Analytics) {
        self.anlytics = anlytics
    }
    
    func getBackAny() {
        anlytics = GoogleAnlytics()
    }
    
    func getAny()
    
    
 
}









class LoginViewModel {
    func loginSuccess() {
//          .typeAnalytics.setAnalyticsParam(Constant.loginEvent, ["isSuccess": true])
    }

}




// login


struct Constant {
    static let loginEvent = "Login_Event"
}


