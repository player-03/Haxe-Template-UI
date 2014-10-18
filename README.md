Haxe Template UI
================

[About templates in Haxe](http://old.haxe.org/doc/cross/template)

[Try it online](http://www.fastswf.com/N5GSsRU)!

Things to try
-------------

# Click the arrow and note the output. Currently only the "$$regexReplace" section is being included in the output.
# Change "`t = 0`" to "`t = 1`", click the arrow, and observe the difference. Now it's including everything after line 3 of the template.
# Remove the "w" from "`wor?d`". Now only the middle line gets included, thanks to the "$$includeIf" macro.

Notes
-----

- You can press Ctrl+Enter or F5 to execute the template.
- When calling macros, do not surround your strings in quotes. Also keep in mind that any spaces before or after your string will be included in the string.
- Macro functions can execute arbitrary code. For fun, try this: `flash.Lib.current.stage.getChildAt(0).visible = false;`
- Certain functions that are available normally may not be available to the macros. One such example is `Ereg.replace()`, which is why `regexReplace()` uses a workaround.
- It is not possible to nest a macro within a conditional, but it is possible to use another macro to get the behavior you want. For an example, change `t = 0` to `t = 1`.
