import Foundation
import lex

public struct MdToObject {

    // scan the mardown lexems for {.className}, if found
    // call a func to feed object properties
    // return the index of the Class lexem, else -1
    static public func feed<T>(object: inout T, using keypaths: [WritableKeyPath<T,String>], from lexems: [MdLexem], className:String) -> Int {
        // print(lexems)
        for (i,lexem) in lexems.enumerated() {
            if case MdLexem.Class = lexem {
                if let _ = getTextValue(from: lexems, at: i+1) {
                    feed(object: &object, using: keypaths, from: lexems, at: i)
                    return i
                }
            }
        }
        return -1
    }

    // feed object properties with text lexems.
    static private func feed<T>(object: inout T, using keypaths: [WritableKeyPath<T,String>], from lexems: [MdLexem], at index: Int) -> Void {
        // get the text values from lexems
        var values = getTextValues(from: lexems, from: index+2, maxCount: keypaths.count)
        if let value_before = getTextValue(from: lexems, at: index-1) {
            values.insert(value_before, at: 0)
        }
        // set properties = values
        for (i,kp) in keypaths.enumerated() {
            guard i < values.count else { break }
            object[keyPath: kp] = values[i]
        }
    }

    // get a "Text" lexem value at position 'index' in 'lexems'
    static private func getTextValue(from lexems:[MdLexem], at index:Int) -> String? {
        guard index >= 0 && index < lexems.count else { return nil }
        if case MdLexem.Text(let value) = lexems[index] {
            return value
        }
        return nil
    }

    // get string values in 'Text' lexems, from index,
    // until next 'Class' lexem encountered
    static private func getTextValues(from lexems:[MdLexem], from index:Int, maxCount:Int) -> [String] {
        var r:[String] = []
        guard index >= 0 && index < lexems.count else { return r }
        var i = 0
        for l in lexems[index...] {
            guard i < maxCount else  { return r }
            switch l {
                case MdLexem.Text(let value):
                    r.append(value)
                    i += 1
                case MdLexem.Class:
                    return r
                default:
                    ()
            }
        }
        return r
    }

}
