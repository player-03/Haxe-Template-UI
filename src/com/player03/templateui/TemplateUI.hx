/*
 * The MIT License (MIT)
 * 
 * Copyright (c) 2014 Joseph Cloutier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.player03.templateui;

import haxe.Json;
import haxe.Log;
import haxe.PosInfos;
import haxe.Template;
import hscript.exec.Interp;
import hscript.Expr;
import hscript.Parser;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.FocusEvent;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.ui.Keyboard;

/**
 * @author Joseph Cloutier
 */
class TemplateUI extends Sprite {
	private static inline var MARGIN:Int = 5;
	
	private var sourceInput:TextField;
	private var contextInput:TextField;
	private var macroInput:TextField;
	private var outputText:TextField;
	
	public function new() {
		super();
		
		var stage:Stage = Lib.current.stage;
		var stageWidth:Int = stage.stageWidth;
		var stageHeight:Int = stage.stageHeight;
		
		var arrowButton:Sprite = new Sprite();
		arrowButton.addChild(new Bitmap(Assets.getBitmapData("img/Arrow.png")));
		arrowButton.useHandCursor = true;
		arrowButton.buttonMode = true;
		arrowButton.x = (stageWidth - arrowButton.width) / 2;
		arrowButton.y = (stageHeight - arrowButton.height) / 2;
		arrowButton.addEventListener(MouseEvent.CLICK, onClick);
		addChild(arrowButton);
		
		var horizontalDivider:Int = Std.int(stageHeight * 0.6);
		
		var sourceHeader:TextField = newStaticText();
		sourceHeader.width = arrowButton.x;
		sourceHeader.text = "Template";
		addChild(sourceHeader);
		
		sourceInput = newInputText();
		sourceInput.x = MARGIN;
		sourceInput.y = sourceHeader.height + MARGIN;
		sourceInput.width = arrowButton.x - MARGIN * 2;
		sourceInput.height = horizontalDivider - sourceInput.y - MARGIN * 2;
		sourceInput.text = StringTools.replace(Assets.getText("text/DefaultTemplate.txt"),
								"\r\n", "\n");
		addChild(sourceInput);
		
		var contextHeader:TextField = newStaticText();
		contextHeader.x = MARGIN;
		contextHeader.y = horizontalDivider;
		contextHeader.text = "Context";
		contextHeader.width = contextHeader.textWidth * 1.1;
		addChild(contextHeader);
		
		var macroHeader:TextField = newStaticText();
		macroHeader.y = horizontalDivider;
		macroHeader.text = "Macro";
		macroHeader.width = macroHeader.textWidth * 1.1;
		macroHeader.x = arrowButton.x - MARGIN - macroHeader.width;
		addChild(macroHeader);
		
		contextInput = newInputText();
		contextInput.x = MARGIN;
		contextInput.y = contextHeader.y + contextHeader.height + MARGIN;
		contextInput.width = arrowButton.x - MARGIN * 2;
		contextInput.height = stageHeight - contextInput.y - MARGIN * 2;
		contextInput.text = StringTools.replace(Assets.getText("text/DefaultContext.txt"),
								"\r\n", "\n");
		addChild(contextInput);
		
		macroInput = newInputText();
		macroInput.x = contextInput.x;
		macroInput.y = contextInput.y;
		macroInput.width = contextInput.width;
		macroInput.height = contextInput.height;
		macroInput.text = StringTools.replace(Assets.getText("text/DefaultMacros.txt"),
							"\r\n", "\n");
		addChild(macroInput);
		
		var tabList:Array<HeaderTab> = new Array<HeaderTab>();
		var contextTab:HeaderTab = new HeaderTab(contextHeader, tabList, contextInput);
		tabList.push(contextTab);
		contextTab.selectTab();
		addChild(contextTab);
		var macroTab:HeaderTab = new HeaderTab(macroHeader, tabList, macroInput);
		tabList.push(macroTab);
		addChild(macroTab);
		
		var outputHeader:TextField = newStaticText();
		outputHeader.x = arrowButton.x + arrowButton.width;
		outputHeader.width = stageWidth - outputHeader.x;
		outputHeader.text = "Output";
		addChild(outputHeader);
		
		outputText = newInputText();
		outputText.x = arrowButton.x + arrowButton.width + MARGIN;
		outputText.y = outputHeader.height + MARGIN;
		outputText.width = stageWidth - outputText.x - MARGIN * 2;
		outputText.height = stageHeight - outputText.y - MARGIN * 2;
		addChild(outputText);
		
		stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, onKeyFocusChange);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyFocusChange(e:FocusEvent):Void {
		e.stopImmediatePropagation();
		e.preventDefault();
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		if(e.keyCode == Keyboard.ENTER && e.ctrlKey || e.keyCode == Keyboard.F5) {
			e.stopImmediatePropagation();
			e.preventDefault();
			
			onClick(null);
		} else if(e.keyCode == Keyboard.TAB) {
			e.stopImmediatePropagation();
			e.preventDefault();
			
			if(Std.is(stage.focus, TextField)) {
				var t:TextField = cast(stage.focus, TextField);
				if(t.type == TextFieldType.INPUT) {
					t.replaceText(t.selectionBeginIndex, t.selectionEndIndex, "\t");
					t.setSelection(t.selectionBeginIndex + 1, t.selectionBeginIndex + 1);
				}
			}
		}
	}
	
	private function traceToOutput(v:Dynamic, ?infos:PosInfos):Void {
		outputText.appendText(infos.fileName + ":" + infos.lineNumber + ": "
							+ Std.string(v) + "\n");
	}
	
	private function onClick(e:MouseEvent):Void {
		Log.trace = traceToOutput;
		outputText.text = "";
		
		try {
			var template:Template = new Template(sourceInput.text);
			
			var context:Dynamic = { };
			var delim:EReg = ~/[ =:]+/i;
			for(line in ~/[\r\n]+/.split(contextInput.text)) {
				if(line.length == 0) {
					continue;
				}
				if(delim.match(line)) {
					Reflect.setField(context, delim.matchedLeft(), delim.matchedRight());
				} else {
					Reflect.setField(context, line, 1);
				}
			}
			
			var macros:Dynamic = { };
			if(macroInput.text.length > 0) {
				var parser:Parser = new Parser();
				var interp:Interp = new Interp();
				addToMacros(macros, parser.parseString(macroInput.text), interp);
			}
			
			outputText.appendText(template.execute(context, macros));
		} catch(e:Dynamic) {
			if(Std.is(e, hscript.Expr.Error)) {
				outputText.appendText(Std.string(cast(e, hscript.Expr.Error).error));
			} else {
				outputText.appendText(Std.string(e));
			}
		}
	}
	
	private static function addToMacros(macros:Dynamic, expr:Expr, interp:Interp):Void {
		switch(expr.expr) {
			case EFunction(args, expr2, name, ret):
				Reflect.setField(macros, name,
					MacroExecution.getMacroExecutor(name, expr2, interp, args));
			case EBlock(arr):
				for(expr2 in arr) {
					addToMacros(macros, expr2, interp);
				}
			default:
		}
	}
	
	private static function newInputText():TextField {
		var format:TextFormat = new TextFormat(
				Assets.getFont("font/VOCES-REGULAR.TTF").fontName, 16);
		
		var text:TextField = new TextField();
		text.defaultTextFormat = format;
		text.embedFonts = true;
		text.type = TextFieldType.INPUT;
		text.border = true;
		text.multiline = true;
		text.wordWrap = true;
		
		text.text = "Hg";
		text.height = text.textHeight * 1.1;
		text.text = "";
		
		return text;
	}
	
	private static function newStaticText():TextField {
		var format:TextFormat = new TextFormat(
				Assets.getFont("font/VOCES-REGULAR.TTF").fontName, 24,
				TextFormatAlign.CENTER);
		
		var text:TextField = new TextField();
		text.defaultTextFormat = format;
		text.embedFonts = true;
		text.selectable = false;
		
		text.text = "Mercury";
		text.height = text.textHeight * 1.1;
		text.text = "";
		
		return text;
	}
}
