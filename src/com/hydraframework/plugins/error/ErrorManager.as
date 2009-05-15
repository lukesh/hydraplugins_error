/*
   HydraFramework - Copyright (c) 2009 andCulture, Inc. Some rights reserved.
   Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package com.hydraframework.plugins.error {
	import com.hydraframework.core.mvc.events.Notification;
	import com.hydraframework.core.mvc.events.Phase;
	import com.hydraframework.core.mvc.patterns.plugin.Plugin;
	import com.hydraframework.plugins.error.descriptors.ErrorDescriptor;
	import mx.collections.ArrayCollection;

	public class ErrorManager extends Plugin {
		public static const NAME:String = "ErrorManager";
		public static const ERROR:String = "plugins.error.error";
		public static const ERROR_ADD:String = "plugins.error.errorAdd";
		public static const ERROR_REMOVE:String = "plugins.error.errorRemove";
		public static const ERROR_REMOVE_ALL:String = "plugins.error.errorRemoveAll";

		public function ErrorManager() {
			super(NAME);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/**
		 * @private
		 * Cached instance of the ErrorManager.
		 */
		private static const _instance:ErrorManager = new ErrorManager();

		/**
		 * Returns a cached instance of the ErrorManager.
		 */
		public static function getInstance():ErrorManager {
			return _instance;
		}
		/**
		 * @private
		 */
		private var _errors:ArrayCollection = new ArrayCollection();

		/**
		 * Returns an ArrayCollection of all currently recorded errors
		 */
		public static function get errors():ArrayCollection {
			return ErrorManager.getInstance()._errors;
		}

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  ADD
		//----------------------------------
		/**
		 * @param errorMessage String description of the error to be added
		 */
		public static function add(error:ErrorDescriptor):void {
			ErrorManager.getInstance().addErrorToList(error);
		}

		//----------------------------------
		//  REMOVE
		//----------------------------------
		/**
		 * @param errorMessage String description of the error to be removed
		 * @param count number of records matching errorMessage to be removed from the error log.
		 *              Default value of 0 will remove all occurances of errorMessage
		 */
		public static function removeErrorById(id:int, count:int = 0):void {
			ErrorManager.getInstance().removeErrorFromListById(id, count);
		}

		/**
		 * Removes all errors in the error list.
		 */
		public static function removeAllErrors():void {
			ErrorManager.getInstance().removeAllErrorsFromList();
		}

		/**
		 * Locates all Errors that match the supplied type and removes them from the list.
		 * Each removal utilizes the removeErrorById method and defers to it for all
		 * notifications
		 *
		 * @see removeErrorById
		 */
		public static function removeAllErrorsByType(type:String):void {
			ErrorManager.getInstance().removeAllErrorsFromList(type);
		}

		//----------------------------------
		//  DEBUG
		//----------------------------------
		/**
		 * Outputs all error records to the console
		 *
		 * @param indent String to concatenate to the beginning of each new error
		 */
		public static function traceErrors(indent:String = "   "):void {
			ErrorManager.getInstance().traceErrorsToConsole(null, indent);
		}

		/**
		 * Outputs all error records of a specified type to the console
		 *
		 * @param type String literal of the desired error type to print
		 * @param indent String to concatenate to the beginning of each new error
		 */
		public static function traceErrorsByType(type:String, indent:String = "    "):void {
			ErrorManager.getInstance().traceErrorsToConsole(type, indent);
		}

		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * @private
		 */
		private function addErrorToList(error:ErrorDescriptor):void {
			this.sendNotification(new Notification(ErrorManager.ERROR_ADD, this._errors, Phase.REQUEST));
			this._errors.addItemAt(error, 0);
			this.sendNotification(new Notification(ErrorManager.ERROR_ADD, this._errors, Phase.COMPLETE));
			this.sendNotification(new Notification(ErrorManager.ERROR, error, Phase.RESPONSE, true));
		}

		/**
		 * @private
		 */
		private function removeErrorFromListById(id:int, count:int = 0):void {
			this.sendNotification(new Notification(ErrorManager.ERROR_REMOVE, this._errors, Phase.REQUEST));

			if (this._errors.getItemAt(id) is ErrorDescriptor) {
				this._errors.removeItemAt(id);
			}
			this.sendNotification(new Notification(ErrorManager.ERROR_REMOVE, this._errors, Phase.COMPLETE));
		}

		/**
		 * @private
		 */
		private function removeAllErrorsFromList(type:String = null):void {
			if (type != null) {
				/* By Type */
				var errorCount:int = this._errors.length;

				for (var i:int = 0; i < errorCount; i++) {
					var currError:ErrorDescriptor = this._errors.getItemAt(i) as ErrorDescriptor;

					if (type == currError.type.toString()) {
						removeErrorFromListById(i);
						removeAllErrorsFromList(type);
						break;
					}
				}
			} else {
				/* All */
				this.sendNotification(new Notification(ErrorManager.ERROR_REMOVE_ALL, this._errors, Phase.REQUEST));
				this._errors.removeAll();
				this.sendNotification(new Notification(ErrorManager.ERROR_REMOVE_ALL, this._errors, Phase.COMPLETE));
			}
		}

		/**
		 * @private
		 */
		protected function traceErrorsToConsole(sortType:String = null, indent:String = "    "):void {
			var errorCount:int = this._errors.length;
			var printCount:int = 0;
			var printStr:String = "";

			for (var i:int = 0; i < errorCount; i++) {
				var currError:ErrorDescriptor = this._errors.getItemAt(i) as ErrorDescriptor;

				if (sortType == null || sortType == currError.type.toString()) {
					if (printCount >= 1)
						printStr += "\n";
					printStr += (indent + "Error[" + i + "] => " + currError);
					printCount++;
				}
			}

			if (printStr == "")
				printStr = (indent + "No errors logged.");
			trace("[ErrorManager.traceErrors (DisplayedErrors=" + printCount + ", TotalErrors=" + errorCount + ")] Begin\n" + printStr + "\n[ErrorManager.traceErrors] End");
		}
	}
}