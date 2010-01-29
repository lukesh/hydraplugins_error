/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package com.hydraframework.plugins.error.interfaces {

	public interface IErrorDescriptor {
		function get type():IErrorType;
		function set type(value:IErrorType):void;
		function get message():String;
		function set message(value:String):void;
		function toString():String;
	}
}