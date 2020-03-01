# machine
`machine` is a 'program that reads a program' and executes its instructions.

Programs are issued from a `lex` compilation, using a langage you defined.

Following execution, the results are available in the machine's memory.

# Example 
The example reads `lex` programs compiled from markdown files.
These programs contain some instructions that use a '.' operator.
This operator is used to designate a class name.
In the program sequence, it is an infix operator that applies on 2 tokens before and 'n' tokens after.
When executed, the instruction does : 
- create an object of the designated class
- feed the object properties with the values of the 2 previous tokens from the program
- continue with next tokens, until no more token or no more property is available

## An example program
```
[
lex.MdLexem.Level1, lex.MdLexem.Text("Title "), lex.MdLexem.BracketOpen,
lex.MdLexem.Class("flyer"), lex.MdLexem.BracketClose, lex.MdLexem.Level2,
lex.MdLexem.Text("SubTitle"), lex.MdLexem.Level3, lex.MdLexem.Text("Paragraph title"),
lex.MdLexem.Level4, lex.MdLexem.Text("Paragraph subTitle"), lex.MdLexem.Text("notes")
]
```

## Executing the .Class instruction
In the mardown expression `'# Title {.Flyer}\n## Sub title\nSome text'`,
`'.'` applies to `'# Title'` and `'\n## Sub title`', if the class `'Flyer'` has 2 properties.

## The 'Flyer' class
```swift
public struct Flyer {
    var title:String;
    var subTitle:String;
    var partTitle:String;
    var partText:String;
    var moreInfo:String;
}
```

## Using the machine

### Implement the '.' instruction
```swift
func dot_class(program:[MdLexem], tokenIndex:Int) {
    - create an object of the designated class
    - feed its properties with the 2 previous tokens in the program
    - continue with next tokens, until no more token or no more property is available
    - add the object onto the machine heap memory
}
```
### Add the instruction to the machine
```swift
machine.addInstruction(
    operator: "lex.MdLexem.Class",
    funct: dot_class
) {}
```
### Execute a program
```swift
machine.run(
"""
[
lex.MdLexem.Level1, lex.MdLexem.Text("Title "), lex.MdLexem.BracketOpen,
lex.MdLexem.Class("flyer"), lex.MdLexem.BracketClose, lex.MdLexem.Level2,
lex.MdLexem.Text("SubTitle"), lex.MdLexem.Level3, lex.MdLexem.Text("Paragraph title"),
lex.MdLexem.Level4, lex.MdLexem.Text("Paragraph subTitle"), lex.MdLexem.Text("notes")
]
"""
```

### Get the result
```swift
machine.print()
```

# About the machine

## Available functions
```swift
func addInstruction( operator: lex.MdLexem, funct: ([MdLexem],Int)->Void ) {}
func clear() // clear the machine memory
func run(program:String)
func print() // print the machine memory
func store(id:String, object:Any) // into the memory (a dictionary map)
func retrieve(id) -> Any
```

## What 'run' does
```swift
) {
    - loop over instructions
    - swith/case with registered machine instructions to call funct
}
```
