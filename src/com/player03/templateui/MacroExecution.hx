package com.player03.templateui;
import hscript.exec.Interp;
import hscript.Expr;

/**
 * One big workaround.
 * @author Joseph Cloutier
 */
class MacroExecution {
	public static function getMacroExecutor(name:String, expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>):Dynamic {
		if(expectedArgs.length < 1 || expectedArgs[0].name != "resolve") {
			throw 'Error: Function $name() is missing the "resolve:String->Dynamic" argument.';
		}
		switch(expectedArgs.length) {
			case 1:
				return execute1.bind(expr, interp, expectedArgs);
			case 2:
				return execute2.bind(expr, interp, expectedArgs);
			case 3:
				return execute3.bind(expr, interp, expectedArgs);
			case 4:
				return execute4.bind(expr, interp, expectedArgs);
			case 5:
				return execute5.bind(expr, interp, expectedArgs);
			case 6:
				return execute6.bind(expr, interp, expectedArgs);
			case 7:
				return execute7.bind(expr, interp, expectedArgs);
			case 8:
				return execute8.bind(expr, interp, expectedArgs);
			case 9:
				return execute9.bind(expr, interp, expectedArgs);
			case 10:
				return execute10.bind(expr, interp, expectedArgs);
			default:
				throw 'Error: Function $name() has too many arguments; the maximum is 10.';
		}
	}
	
	private static function executeMacro(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>, args:Array<Dynamic>):Dynamic {
		for(i in 0...expectedArgs.length) {
			interp.variables.set(expectedArgs[i].name, args.length > i ? args[i] : null);
		}
		
		var result:Dynamic = interp.execute(expr);
		
		for(i in 0...expectedArgs.length) {
			interp.variables.remove(expectedArgs[i].name);
		}
		
		return result;
	}
	
	//The things I do to work around Haxe's limitations...
	private static function execute1(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs, [arg0]);
	}
	
	private static function execute2(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs, [arg0, arg1]);
	}
	
	private static function execute3(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs, [arg0, arg1, arg2]);
	}
	
	private static function execute4(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3]);
	}
	
	private static function execute5(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4]);
	}
	
	private static function execute6(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic, arg5:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4, arg5]);
	}
	
	private static function execute7(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic, arg5:Dynamic, arg6:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4, arg5, arg6]);
	}
	
	private static function execute8(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic, arg5:Dynamic, arg6:Dynamic, arg7:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7]);
	}
	
	private static function execute9(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic, arg5:Dynamic, arg6:Dynamic, arg7:Dynamic,
				arg8:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]);
	}
	
	private static function execute10(expr:Expr, interp:Interp,
				expectedArgs:Array<{ name : String, t : Null<CType> }>,
				arg0:Dynamic, arg1:Dynamic, arg2:Dynamic, arg3:Dynamic,
				arg4:Dynamic, arg5:Dynamic, arg6:Dynamic, arg7:Dynamic,
				arg8:Dynamic, arg9:Dynamic):Dynamic {
		return executeMacro(expr, interp, expectedArgs,
			[arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]);
	}
}