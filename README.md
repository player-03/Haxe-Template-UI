Haxe Template UI
================

A basic utility for testing [Haxe's templates](http://old.haxe.org/doc/cross/template). To run it, [download](https://github.com/player-03/Haxe-Template-UI/raw/master/bin/flash/bin/TemplateUI.swf) the SWF, and choose to open it in your browser. The app is also [available online](http://www.fastswf.com/N5GSsRU).

Notes
-----

- You can press Ctrl+Enter or F5 to execute the template.
- When calling macros, do not surround your strings in quotes. Also keep in mind that any spaces before or after your string will be included in the string.
- Macro functions can execute arbitrary code. For fun, try this: `flash.Lib.current.stage.getChildAt(0).visible = false;`
- Certain functions that are available normally may not be available to the macros. One such example is `Ereg.replace()`, which is why `regexReplace()` uses a workaround.
- It is not possible to nest a macro within a conditional, but it is possible to use another macro to get the behavior you want. For an example, change `t = 0` to `t = 1`.
