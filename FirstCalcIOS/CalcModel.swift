//
//  CalcModel.swift
//  FirstCalcIOS
//
//  Created by 이상묵 on 2018. 6. 21..
//  Copyright © 2018년 이상묵. All rights reserved.
//

import Foundation


class ClacModel
{
    private var accumulator = 0.0
    
    var operations : Dictionary<String, Operation> = [
        "π":Operation.Constant(Double.pi),//Double.pi,
        "e":Operation.Constant(M_E),//M_E,
        "√":Operation.UnaryOperation(sqrt),//sqrt,
        "cos":Operation.UnaryOperation(cos),
        "*":Operation.BinaryOperation({$0 * $1}),
        "/":Operation.BinaryOperation({$0 / $1}),
        "+":Operation.BinaryOperation({$0 + $1}),
        "-":Operation.BinaryOperation({$0 - $1}),
        "=":Operation.Equals,
        "C":Operation.Constant(0.0),
    ]
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func setOperand(operand : Double) {
        accumulator = operand
    }
    
    func performOperation(Symbol : String){
        if let Operation = operations[Symbol]
        {
            switch Operation {
            case .Constant(let value) :
                accumulator = value
                
            case .UnaryOperation(let foo):
                accumulator = foo(accumulator)
                
            case .BinaryOperation(let foo):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryfunction: foo, firstOperand: accumulator)
                
            case .Equals:
                    executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil{
            accumulator = pending!.binaryfunction(pending!.firstOperand, accumulator)
        }
    }
    
    //옵셔널 변수 - 이항연산만 사용할 수 있다 나머지연산은 nil로 사용하기 위해서
    private var pending : PendingBinaryOperationInfo?
    
    //**구조체와 클래스의 차이**
    //구조체는 call by value
    //클래스는 call by reference
    //클래스는 초기화 함수가 자동으로 생성됨
    //구조체는 포함된 멤버들 자체가 초기화 변수들
    
    struct PendingBinaryOperationInfo{
        var binaryfunction:(Double,Double)->Double
        var firstOperand: Double
    }
    
    var result : Double{
        get{
            return accumulator
        }
    }
}
