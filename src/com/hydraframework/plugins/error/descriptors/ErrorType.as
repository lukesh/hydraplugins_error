/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error.descriptors {

	public class ErrorType {
		public static const WARNING:ErrorType = new ErrorType("ErrorType.warning");
		public static const ERROR:ErrorType = new ErrorType("ErrorType.error");
		public static const FATAL:ErrorType = new ErrorType("ErrorType.fatal");
		public var type:String;

		public function ErrorType(type:String) {
			this.type = type;
		}

		public function toString():String {
			return this.type;
		}
	}
}