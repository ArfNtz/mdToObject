import Foundation
import machine
import lex

// a markdon
let text_md = """
# Title {.Flyer}
## SubTitle
### Paragraph title
#### Paragraph subTitle
notes
"""

// an object
public struct Flyer {
    var title:String = ""
    var subTitle:String = ""
    var partTitle:String = ""
    var partText:String = ""
    var moreInfo:String = "la"
}

// lex the markdown
let lexems = lex(text_md, md_dict)

// feed an object instance with markdown
var f = Flyer()
let keypaths = [\Flyer.title,\Flyer.subTitle,\Flyer.partTitle,\Flyer.partText,\Flyer.moreInfo]
MdToObject.feed(object: &f, using: keypaths, from: lexems, className: "Flyer")
print(f)
