/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error.descriptors {
	
	import com.hydraframework.plugins.error.interfaces.IErrorDescriptor;
	import com.hydraframework.plugins.error.interfaces.IErrorType;

	public class ErrorDescriptor implements IErrorDescriptor{
		
		private var _type:IErrorType;

		public function get type():IErrorType {
			return _type;
		}

		public function set type(value:IErrorType):void {
			_type = value;
		}

		private var _message:String;

		public function get message():String {
			return _message;
		}

		public function set message(value:String):void {
			_message = value;
		}

		public function ErrorDescriptor(type:IErrorType, message:String) {
			this.type = type;
			this.message = message;
		}

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Creates a simple string representation of the ErrorDescriptor's current state
		 *
		 * Note: No need to do trace( error.toString() ); Simply do trace( error );
		 */
		public function toString():String {
			return "[" + this.type + "]: " + this.message;
		}
	}
}