/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error.descriptors {
	
	import com.hydraframework.plugins.error.interfaces.IErrorType;

	public class ErrorType implements IErrorType{
		
		public static const WARNING:ErrorType = new ErrorType("ErrorType.warning");
		public static const ERROR:ErrorType = new ErrorType("ErrorType.error");
		public static const FATAL:ErrorType = new ErrorType("ErrorType.fatal");
		public static const VALIDATION:ErrorType = new ErrorType("ErrorType.validation");
		
		private var _type:String;

		public function get type():String {
			return _type;
		}

		public function set type(value:String):void {
			_type = value;
		}

		public function ErrorType(type:String) {
			this.type = type;
		}

		public function toString():String {
			return this.type;
		}
	}
}