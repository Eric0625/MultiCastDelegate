# MultiCastDelegate
## Implementing multi cast of delegate in Swift 
## 实现Swift下的多播委托（中文说明见下）

As we know Swift only support weak/unowned key word for class variables,not for array or collection types. But multicast delegating require storing delegate protocol in arrays. So simply create an array of protocol will point a strong refrence to the delegate which will eventually cause 1.refrence cycle, 2.the delegate may never be released if the caller is static.

This MuitiCastDelgator was built to solve such problem, it can give you simple resolution of multicast in Swift.The features are:

1. Pure swift implemention, strong type checking and full support to all protocol

2. Only create weak refrence , same as the single delegate pattern

3. Auto cleaning of destroied delegates.

4. Very simple usage.(4 steps)

### Usage:

1.Define your protocol(put it anywhere, either in single file or before the class definition)

```
protocol DisplayMessageDelegate {
    func displayMessage(_ message:String)
}
```

2.In your class from which the message is sent, define a variable of MultiCastDelegator type

`
let handler = MultiCastDelegator <DisplayMessageDelegate>()
`

3.In the same class, write the code at the place where you want to send the message

`
handler.invoke(){ $0.displayMessage(message) }
`

4.In the receiver class, pass `self` to the `handler` variable, then implement the protocol

```
...
MainClass.handler += self
...

extension YourReceiver: DisplayMessageDelegate {
    func displayMessage(_ message: String) {
      //display the message
    }
}
```

### Full sample code:<br>
```
protocol DisplayMessageDelegate {
    func displayMessage(_ message: String)
}

class MessageBox: DisplayMessageDelegate {

    init(){
      main.handler += self
    }
   
    func displayMessage(_ message: String) {
      //display the message
    }
}

class MessageBoard: DisplayMessageDelegate {

    init(){
      MainClass.handler += self
    }
    
    func displayMessage(_ message: String) {
      //display the message
    }
}

class MainClass {
    static let handler = MultiCastDelegator <DisplayMessageDelegate>()
    class func timeToDisplay(information: String) {
        handler.invoke(){ $0.displaymessage(information) }
    }
}

let displayer1 = MessageBox()
let displayer2 = MessageBoard()

//when you need to display, call it
MainClass.timeToDisplay("the message")
```

我们都知道Swift只支持对单个变量声明weak或unowned关键字。但多播委托要求将委托者存入一个数组或链表中。如果只是简单地实现一个委托数组，则数组中元素均为强引用，这样所有的委托者都有可能和主类形成循环引用，或者在主类是静态类型的情况下该委托者永远不会被释放。

<br>这个MuitiCastDelgator类即可解决上述问题。它具备如下特性：

1.只创建弱引用

2.自动清理已被释放的委托者

3.简单明了的使用方法

### 使用方法:

1.构造你的委托协议

```
protocol DisplayMessageDelegate {
    func displayMessage(_ message:String)
}
```

2.在主类中，基于该协议定义一个变量

`
let handler = MultiCastDelegator <DisplayMessageDelegate>()
`

3.在需要触发的地方，写如下代码

`
handler.invoke(){ $0.displayMessage(message) }
`

### 完整例子:<br>
```
protocol DisplayMessageDelegate {
    func displayMessage(_ message: String)
}

class MessageBox: DisplayMessageDelegate {

    init(){
      main.handler += self
    }
    
    func displayMessage(_ message: String) {
      //display the message
    }
}

class MessageBoard: DisplayMessageDelegate {

    init(){
      MainClass.handler += self
    }
   
    func displayMessage(_ message: String) {
      //display the message
    }
}

class MainClass {
    static let handler = MultiCastDelegator <DisplayMessageDelegate>()
    class func timeToDisplay(information: String) {
        handler.invoke(){ $0.displaymessage(information) }
    }
}

let displayer1 = MessageBox()
let displayer2 = MessageBoard()

//在需要显示信息的地方调用它
MainClass.timeToDisplay("the message")
```
