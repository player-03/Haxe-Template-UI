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

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.text.TextField;

/**
 * @author Joseph Cloutier
 */
class HeaderTab extends Sprite {
	private var text:TextField;
	private var tabList:Array<HeaderTab>;
	private var contents:DisplayObject;
	
	/**
	 * After creating all the tabs you want, remember to call selectTab()
	 * on the one you want selected.
	 * @param	tabList A list of all the tabs competing for the same space.
	 * It's ok if this list isn't fully populated yet.
	 * @param	contents The object to display while this tab is active.
	 * The HeaderTab will not add this as a child; it will just toggle
	 * the contents' visibility as appropriate (starting with invisible).
	 */
	public function new(text:TextField, tabList:Array<HeaderTab>, contents:DisplayObject) {
		super();
		
		this.text = text;
		text.mouseEnabled = false;
		addChild(text);
		
		var textBounds:Rectangle = text.getBounds(this);
		graphics.beginFill(0xFFFFFF, 0);
		graphics.drawRect(textBounds.x, textBounds.y, textBounds.width, textBounds.height);
		
		this.tabList = tabList;
		this.contents = contents;
		
		buttonMode = true;
		useHandCursor = true;
		addEventListener(MouseEvent.CLICK, onClicked);
		
		deselectTab();
	}
	
	private function onClicked(e:MouseEvent):Void {
		selectTab();
	}
	
	public function selectTab():Void {
		text.alpha = 1;
		contents.visible = true;
		
		for(tab in tabList) {
			if(tab != this) {
				tab.deselectTab();
			}
		}
	}
	
	public function deselectTab():Void {
		text.alpha = 0.5;
		contents.visible = false;
	}
	
}
