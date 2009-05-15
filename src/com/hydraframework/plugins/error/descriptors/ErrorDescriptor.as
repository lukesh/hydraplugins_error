/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error.descriptors {

	public class ErrorDescriptor {
		public var type:ErrorType;
		public var message:String;

		public function ErrorDescriptor(type:ErrorType, message:String) {
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