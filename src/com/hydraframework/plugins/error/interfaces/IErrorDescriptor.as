/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
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