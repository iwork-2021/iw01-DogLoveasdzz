//
//  Calculator.swift
//  MyCalculator
//
//  Created by 苏颖康 on 2021/10/12.
//

import UIKit

class Calculator: NSObject {
    enum Operation {
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOP
        case Constant(Double)
        case GetOp(()->Double)
    }
    
    var operations = [
        "+": Operation.BinaryOp{
            (op1, op2) in
            return op1 + op2
        },
        
        "-": Operation.BinaryOp{
            (op1, op2) in
            return op1 - op2
        },
        
        "*": Operation.BinaryOp{
            (op1, op2) in
            return op1 * op2
        },
        
        "/": Operation.BinaryOp{
            (op1, op2) in
            return op1 / op2
        },
        
        "=": Operation.EqualOP,
        
        "%": Operation.UnaryOp{
            op in
            return op / 100.0
        },
        
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        
        "AC": Operation.UnaryOp{
            _ in
            return 0
        },
        
        "Rand": Operation.GetOp{
            return drand48()
        },
        
        "Pi": Operation.Constant(3.14159),
        
        "tanh": Operation.UnaryOp{
            op in
            return tanh(op)
        },
        
        "cosh": Operation.UnaryOp{
            op in
            return cosh(op)
        },
        
        "sinh": Operation.UnaryOp{
            op in
            return sinh(op)
        },
        
        "EE": Operation.BinaryOp{
            (op1, op2) in
            return op1 * pow(10, op2)
        },
        
        "e": Operation.Constant(2.71828),
        
        "tan": Operation.UnaryOp{
            op in
            return tan(op)
        },
        
        "cos": Operation.UnaryOp{
            op in
            return cos(op)
        },
        
        "sin": Operation.UnaryOp{
            op in
            return sin(op)
        },
        
        "x!": Operation.UnaryOp{
            op in
            var index = 1
            var result = 1
            while (index <= Int(op)){
                result = result * index
                index = index + 1
            }
            return Double(result)
        },
        
        "log": Operation.UnaryOp{
            op in
            return log(op) / log(10)
        },
        
        "ln": Operation.UnaryOp{
            op in
            return log(op)
        },
        
        "x^(1/y)": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, 1/op2)
        },
        
        "x^(1/3)": Operation.UnaryOp{
            op in
            return pow(op, 1/3)
        },
        
        "x^(1/2)": Operation.UnaryOp{
            op in
            return pow(op, 1/2)
        },
        
        "1/x": Operation.UnaryOp{
            op in
            return 1/op
        },
        
        "10^x": Operation.UnaryOp{
            op in
            return pow(10.0, op)
        },
        
        "e^x": Operation.UnaryOp{
            op in
            return pow(2.71828, op)
        },
        
        "x^y": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, op2)
        },
        
        "x^3": Operation.UnaryOp{
            op in
            return pow(op, 3.0)
        },
        
        "x^2": Operation.UnaryOp{
            op in
            return pow(op, 2.0)
        },
        
        "mc": Operation.UnaryOp{
            op in
            Calculator.memaryClear()
            return 0.0
        },
        
        "m+": Operation.UnaryOp{
            op in
            return Calculator.memaryAdd(operand: op)
        },
        
        "m-": Operation.UnaryOp{
            op in
            return Calculator.memarySub(operand: op)
        },
        
        "mr": Operation.GetOp{
            return Calculator.memaryRead()
        }
    ]
    
    struct Intermediate{
        var firstOp: Double
        var waitingOpeartion: (Double, Double) -> Double
    }
    var pendingOp: Intermediate? = nil
    var isBianryCal = false
    static var memary = 0.0
    
    static func memaryAdd(operand: Double)->Double {
        memary = memary + operand
        return memary
    }
    
    static func memarySub(operand: Double)->Double {
        memary = memary - operand
        return memary
    }
    
    static func memaryRead()->Double {
        return memary
    }
    
    static func memaryClear() {
        memary = 0.0
    }
    
    func performOperation(operation: String, operand: Double)->Double? {
        if let op = operations[operation] {
            switch op {
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOpeartion: function)
                isBianryCal = true
                return nil
            case .Constant(let value):
                return value
            case .EqualOP:
                if isBianryCal{
                    isBianryCal = false
                    return pendingOp!.waitingOpeartion(pendingOp!.firstOp, operand)
                }
                else {
                    return operand
                }
            case .UnaryOp(let function):
                return function(operand)
            case .GetOp(let function):
                return function()
            }
        }
        return nil
    }
}
