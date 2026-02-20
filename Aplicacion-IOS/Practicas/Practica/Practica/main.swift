//
//  main.swift
//  Practica
//
//  Created by Axel Vargas Díaz de Vivar on 18/02/26.
//

import Foundation

var a: Int?
print(a)

var b: Int? = 5
print(b)
print(b!)

///////////////////////////////////////////////
if let new_b = b
    {
        print(new_b)
    } else
    {
        print ("variable nula")
    }

///////////////////////////////////////////////
if let new_a = a
    {
        print(new_a)
    } else {
        print("variable nula")
    }
    print(5 is Int)
    print("swift" is Int)

///////////////////////////////////////////////

func getEmail(correo: String?)
{
    
    if let new_correo = correo {
        print(new_correo)
        print("Mi correo es:", new_correo)
    } else {
        print("variable nula")
    }
}

getEmail(correo: "axel@gmail.com")
/////////////////////////////////////////

func convert(num: String) -> Int? {
    
    var result: Int? = Int(num)
    
    if let new_result = result {
        result = new_result + 10
    } else {
        print("no castear")
        result = nil
    }
    
    return result
}

/////////////////////////////////////////
func convertAndPrint(num: String) -> Int? {
    
    if let number = Int(num) {
        return number + 10
    } else {
        print("no castear")
        return nil
    }
}

/////////////////////////////////////////
if let r = convert(num: "123")
{
    print(r)
}

/////////////////////////////////////////






