/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error.descriptors {
	
	import com.hydraframework.plugins.error.interfaces.IErrorDescriptor;
	import com.hydraframework.plugins.error.interfaces.IValidationDictionary;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class ValidationDictionary extends EventDispatcher implements IValidationDictionary {

		public function ValidationDictionary(target:IEventDispatcher = null) {
			super(target);
		}

		//-----------------------------
		//
		//	Properties
		//
		//-----------------------------

		/**
		 * @private
		 */
		private var _errors:Dictionary = new Dictionary();

		/**
		 * @private
		 * Current number of errors
		 */
		private var _errorCount:int = 0;

		/**
		 * The current number of errors.
		 */
		public function get errorCount():int {
			return _errorCount;
		}

		/**
		 * Check whether the object as a whole is valid.
		 */
		public function get isValid():Boolean {
			return (_errorCount == 0);
		}

		/**
		 * Property access to errors.
		 */
		public function get errors():Array {
			return this.listErrors();
		}

		//-----------------------------
		//
		//	Public Methods
		//
		//-----------------------------

		/**
		 * Override this method to perform validation.
		 */
		public function validate():Boolean {
			return this.isValid;
		}

		/**
		 * Check whether a key/field is valid.
		 */
		[Bindable(event="errorChanged")] //Make sure this is also in any interfaces you are using
		public function hasError(key:Object):Boolean {
			for (var currentKey:Object in _errors)
				if (currentKey == key)
					return true;
			return false;
		}

		/**
		 * Retrieves an error associated with the supplied key.
		 *
		 * @return IErrorDescriptor
		 */
		public function getError(key:Object):IErrorDescriptor {
			if (this.hasError(key)) {
				return IErrorDescriptor(_errors[key]);
			} else {
				return null;
			}
		}

		/**
		 * Records a new error for the supplied key.
		 */
		public function addError(key:Object, errorMessage:String):void {
			_errors[key] = new ErrorDescriptor(ErrorType.VALIDATION, errorMessage);
			_errorCount++;
			this.dispatchEvent(new Event("errorChanged"));
		}

		/**
		 * Adds a custom IErrorDescriptor object.
		 */
		public function addCustomError(key:Object, error:IErrorDescriptor):void {
			_errors[key] = error;
			_errorCount++;
			this.dispatchEvent(new Event("errorChanged"));
		}

		/**
		 * Returns an array of all the currently recorded errors.
		 *
		 * @return Array<IErrorDescriptors>
		 */
		public function listErrors():Array {
			var result:Array = [];

			for each (var currentError:IErrorDescriptor in _errors)
				result.push(currentError);

			return result;
		}

		/**
		 * Creates an array of unique error descriptors based on message.
		 *
		 * @return Array<IErrorDescriptor>
		 */
		public function listUniqueErrors():Array {
			var result:Array = [];

			for each (var currentError:IErrorDescriptor in _errors) {
				var hasBeenFound:Boolean = false;

				for each (var testError:IErrorDescriptor in result) {
					if (testError.message == currentError.message) {
						hasBeenFound = true;
					}
				}

				if (!hasBeenFound) {
					result.push(currentError);
				}
			}

			return result;
		}

		/**
		 * Creates an array of unique error messages.
		 *
		 * @return Array<String>
		 */
		public function listUniqueErrorMessages():Array {
			var currentUniqueErrors:Array = this.listUniqueErrors();
			var result:Array = [];

			for each (var currentError:IErrorDescriptor in currentUniqueErrors) {
				result.push(currentError.message);
			}

			return result;
		}

		/**
		 * Removes any errors matching the supplied descriptor. Returns
		 * whether there was an actual error removed.
		 */
		public function removeError(descriptor:IErrorDescriptor):Boolean {
			var hasRemovedErrors:Boolean = false;

			for (var currentErrorKey:Object in _errors) {
				var currentError:IErrorDescriptor = _errors[currentErrorKey] as IErrorDescriptor;

				if (currentError == descriptor) {
					delete _errors[currentErrorKey];
					_errorCount--;
					this.dispatchEvent(new Event("errorChanged"));
					hasRemovedErrors = true;
				}
			}
			return !hasRemovedErrors;
		}

		/**
		 * Removes any errors for the supplied key. Returns
		 * whether there was an actual record removed.
		 */
		public function removeErrorByKey(key:Object):Boolean {
			if (!this.hasError(key)) {
				delete _errors[key];
				_errorCount--;
				this.dispatchEvent(new Event("errorChanged"));
				return true;
			} else {
				return false;
			}
		}

		/**
		 * Removes all errors that have been recorded.
		 */
		public function clearErrors():void {
			for (var currentKey:Object in _errors) {
				delete _errors[currentKey];
			}
			_errorCount = 0;
			this.dispatchEvent(new Event("errorChanged"));
		}

	}
}