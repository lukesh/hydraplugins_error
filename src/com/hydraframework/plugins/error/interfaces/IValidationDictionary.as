/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package com.hydraframework.plugins.error.interfaces {
	
	import com.hydraframework.plugins.error.interfaces.IErrorDescriptor;

	public interface IValidationDictionary {
		function get errorCount():int;
		function get errors():Array;
		function get isValid():Boolean;
		function addCustomError(key:Object, error:IErrorDescriptor):void;
		function addError(key:Object, errorMessage:String):void;
		function clearErrors():void;
		function getError(key:Object):IErrorDescriptor;
		[Bindable(event="errorChanged")]
		function hasError(key:Object):Boolean;
		function listErrors():Array;
		function listUniqueErrors():Array;
		function listUniqueErrorMessages():Array;
		function removeError(error:IErrorDescriptor):Boolean;
		function removeErrorByKey(key:Object):Boolean;
		function validate():Boolean;
	}
}