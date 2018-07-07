//
//  ViewController.swift
//  FirstCalcIOS
//
//  Created by 이상묵 on 2018. 6. 20..
//  Copyright © 2018년 이상묵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var Display: UILabel!
    
    var using_now : Bool = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let Digit  = sender.currentTitle!
        let totalDigit = Display.text!
        if using_now {
            Display.text = totalDigit + Digit
        }else
        {
            Display.text = Digit
        }
        NSLog("touch digit")
        using_now = true
    }
    
    // 계산할 클래스를 생성한다.
    private var brain = ClacModel()
    
    //디스플레이된 숫자를 가져와서 setOperand함수 적용
    //연산자를 누르면 accumulator에 값을 저장하고
    //해당연산자의 연산을 수행한다.
    @IBAction private func OperationPI(_ sender: UIButton) {
        if using_now {
            brain.setOperand(operand: DisplayValue)
            using_now = false
        }
        
        if let symbol = sender.currentTitle
        {
            NSLog("start operatioin")
            brain.performOperation(Symbol: symbol)
            DisplayValue = brain.result
        }
    }
    
    //디스플레이 값을 가져올떄 string으로, 설정할때 double로 설정
   private var DisplayValue : Double {
        get {
           return Double(Display.text!)!
        }
        set{
            Display.text = String(newValue)
        }
    }
}

