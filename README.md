Haxe Template UI
================

A basic utility for testing [Haxe's templates](http://old.haxe.org/doc/cross/template). To run it, [download](https://github.com/player-03/Haxe-Template-UI/raw/master/bin/flash/bin/TemplateUI.swf) the SWF, and choose to open it in your browser. The app is also [available online](http://www.fastswf.com/B4-PUFA).

Notes
-----

- You can press Ctrl+Enter or F5 to execute the template.
- When calling macros, do not surround your strings in quotes. Also keep in mind that any spaces before or after your string will be included in the string.
- Macro functions can execute arbitrary code. For fun, try this: `flash.Lib.current.stage.getChildAt(0).visible = false;`
- Due to limitations of this implementation, the following will not work: <br>`::if (regexMatch("w",::sampleVar::))::match::end::`. However, it _will_ work in regular use.
