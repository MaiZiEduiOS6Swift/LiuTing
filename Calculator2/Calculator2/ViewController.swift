//
//  ViewController.swift
//  Calculator2
//
//  Created by liu ting on 10/19/15.
//  Copyright © 2015 liu ting. All rights reserved.
//

import UIKit

//用户点击操作符的时候保存用户输入的数字，用户点击=时输出计算结果，用户点击C时清除所有
class ViewController: UIViewController {
    
    //flags
    var userHasTypedNum = false
    var userHasTypedOperator = false
    var userHasTypedEnter = false
    
    //操作数array
    var numbers:[Float] = [0]
    //操作符array
    var operators = [String]()
    //当前操作符
    var currentOperator = ""
    //计算结果
    var result:Float = 0
    
    @IBOutlet weak var display: UILabel!
    

    @IBAction func numberButtonClicked(sender: UIButton) {
        //如果用户点击了等号，那么再点击数字的时候就clear之前的全部运算
        if userHasTypedEnter == true {
            resetAll()
        }
        
        
        //如果用户输入运算符 那么再点击数字的时候显示新的数字
        else if userHasTypedOperator == true {
          display.text = sender.currentTitle!
          userHasTypedOperator = false
        }
        
        //否则用户输入显示拼接
        else{
            display.text! += sender.currentTitle!
        }
        
        //flag用户已经输入数字
        userHasTypedNum = true
        
    }
    
    
    @IBAction func operations(sender: UIButton) {
        //获取当前运算符
        currentOperator = sender.currentTitle!
        //如果用户连续两次输入运算符，清除第一次输入的运算符
        if userHasTypedOperator {
            print("用户连续输入运算符")
            operators.removeLast()
        }
            
        //如果用户输入等号，则标记
        else{
            if userHasTypedEnter == true {
               userHasTypedEnter = false
            }

            //如果用户输入了数字，那么输入运算符的时候，数字入栈，并运算
            else if userHasTypedNum == true {
                numbers.append(Float(display.text!)!)
                userHasTypedNum = false
                //如果用户输入运算符时，运算符array不为空，则判断优先级，计算
                while operators.isEmpty == false {
                    //如果当前输入的运算符优先级比较低，则计算之前所有的运算，否则，不运算
                    let lastOperator = operators[operators.endIndex - 1]
                    if rankOperator(lastOperator) >= rankOperator(currentOperator) {
                        calculate()
                        numbers.append(result)
                    }
                        
                    else {
                        break
                    }
                }
            }
        }
        
        NSBundle
        //运算符入栈并标记
        operators.append(currentOperator)
        userHasTypedOperator = true
        
    }
    
    @IBAction func enter(sender: UIButton) {
        if userHasTypedEnter == false {
        //当前显示的数字入栈
            numbers.append(Float(display.text!)!)
        //计算
            while operators.isEmpty == false {
            calculate()
            numbers.append(result)
            }
        //flag计算结束
            print(numbers)
            print(operators)
            userHasTypedEnter = true
        }
        else {
            print("用户连续输入等号")
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        resetAll()
    }
    
    //所有运算复位
    func resetAll(){
        display.text = ""
        numbers.removeAll()
        numbers.append(0)
        operators.removeAll()
        userHasTypedEnter = false
        userHasTypedOperator = false
    }
    
    //计算
    func calculate(){
        print(numbers)
        print(operators)
        //栈中提取操作数与操作符
        let operation = operators.removeLast()
        let b = numbers.removeLast()
        let a = numbers.removeLast()
            switch operation{
            case "+": result = a + b
            case "−": result = a - b
            case "×": result = a * b
            case "÷": result = b==0 ? 0 : a/b
            default : print("ooops")
            
        }
        //NSNumber可以在显示的时候省略小数点后的0
        display.text = "\(NSNumber(float: result))"
        //清除flag
        userHasTypedOperator = false
        userHasTypedNum = false
    
    }
    
    //操作符判定优先级
    func rankOperator(op:String)-> Int{
        
        switch op{
            case "+": return 1
            case "−": return 1
            case "×": return 2
            case "÷": return 2
        default: return 1
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

