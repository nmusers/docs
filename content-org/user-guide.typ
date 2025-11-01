#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./"
⁠```
#set document(title: "NONMEM User guide", author: "Yi Zhang")
#set text(lang: "en")
#title()
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("org00efc3f")
intro
#heading(level: 1)[Modeling techniques] #label("orgd557308")
modeling
