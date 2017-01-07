# MultiCastDelegate
Implementing multi cast of delegate in Swift 实现Swift下的多播委托

As we know Swift only support weak/unowned key word for class variables,not for array or collection types. But multicast delegating require storing delegate protocol in arrays. So simply create an array of protocol will point a strong refrence to the delegate which will eventually cause refrence cycle.

This MuitiCastDelgator was built to solve such problem, it can give you simple resolution of multicast in Swift.The features are:

1.Only create weak refrence , same as the single delegate pattern

2.Auto cleaning of destroied delegates.

3.Very simple usage.

Usage:

1.Define your protocol

protocol DisplayMessageDelegate {
    func displayMessage(_ message:String)
}

2.In your class which invokes the delegate, define a variable of MultiCastDelegator type

let handler = MultiCastDelegator < DisplayMessageDelegate >()

3.Write the code below where you need to inform delegate to display message

handler.invoke(){ $0.displayMessage(message) }

<b>Full sample code:</b><br>
protocol DisplayMessageDelegate {
    func displayMessage(_ message: String)
}

class MessageBox: DisplayMessageDelegate {

    init(){
      main.handler += self
    }
    
    deinit {
      main.hanlder -= self
    }
    
    func displayMessage(_ message: String) {
      //display the message
    }
}

class MessageBoard: DisplayMessageDelegate {

    init(){
      main.handler += self
    }
    
    deinit {
      main.hanlder -= self
    }
    
    func displayMessage(_ message: String) {
      //display the message
    }
}


