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
import haxe.Template;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * @author Joseph Cloutier
 */
class TemplateUI extends Sprite {
	private static inline var MARGIN:Int = 5;
	
	private var sourceInput:TextField;
	private var contextInput:TextField;
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
		sourceInput.text = "Hello, ::sampleVar::.";
		addChild(sourceInput);
		
		var contextHeader:TextField = newStaticText();
		contextHeader.y = horizontalDivider;
		contextHeader.width = arrowButton.x;
		contextHeader.text = "Context";
		addChild(contextHeader);
		
		contextInput = newInputText();
		contextInput.x = MARGIN;
		contextInput.y = contextHeader.y + contextHeader.height + MARGIN;
		contextInput.width = arrowButton.x - MARGIN * 2;
		contextInput.height = stageHeight - contextInput.y - MARGIN * 2;
		contextInput.text = "sampleVar = world\nt = 0";
		addChild(contextInput);
		
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
	}
	
	private function onClick(e:MouseEvent):Void {
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
		outputText.text = template.execute(context);
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
