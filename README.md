# mdToObject

`mdToObject` feeds an object properties from a markdown text.

# Example 

## a markdown
```swift
let text_md = """
    # Title {.Flyer}
    ## SubTitle
    ### Paragraph title
    #### Paragraph subTitle
    notes
"""
```

## an object
```swift
public struct Flyer {
    var title:String;
    var subTitle:String;
    var partTitle:String;
    var partText:String;
    var moreInfo:String;
}
```

## feed the object from the markdown

```swift
// lex the markdown
let lexems = lex(text_md, md_dict)
// feed an object instance with markdown
var f = Flyer()
let keypaths = [\Flyer.title,\Flyer.subTitle,\Flyer.partTitle,\Flyer.partText,\Flyer.moreInfo]
MdToObject.feed(object: &f, using: keypaths, from: lexems, className: "Flyer")
```

## print the result

```swift
print(f)
```

```
Flyer(title: "Title ", subTitle: "SubTitle", partTitle: "Paragraph title", partText: "Paragraph subTitle", moreInfo: "notes")
```
