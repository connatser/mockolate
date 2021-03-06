package mockolate.runner.statements
{
	import asx.string.formatToString;
	
	import mockolate.errors.MockolateError;
	import mockolate.ingredients.Mockolatier;
	import mockolate.runner.MockolateRunnerConstants;
	import mockolate.runner.MockolateRunnerData;
	import mockolate.runner.MockolateRunnerStatement;
	import mockolate.verify;
	
	import org.flexunit.constants.AnnotationConstants;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.token.AsyncTestToken;
	
	/**
	 * Verifies the Mockolates.  
	 * 
	 * @see mockolate.runner.MockolateRule
	 * @see mockolate.runner.MockolateRunner
	 * 
	 * @author drewbourne
	 */
	public class VerifyMockInstances extends MockolateRunnerStatement implements IAsyncStatement
	{
		/**
		 * Constructor.
		 * 
		 * @param data
		 */
		public function VerifyMockInstances(data:MockolateRunnerData)
		{
			super(data);
		}
		
		/**
		 * @private
		 */
		public function evaluate(parentToken:AsyncTestToken):void 
		{
			this.parentToken = parentToken;	
			
			var error:Error = null;
			var mockolatier:Mockolatier = data.mockolatier;
			
			if (verifyMethod())
			{				
				for each (var mock:Object in data.mockInstances)
				{
					try
					{
						mockolatier.verify(mock);
					}
					catch (e:MockolateError)
					{
						error = e;
						break;
					}
				}
			}
			
			parentToken.sendResult(error);
		}
		
		/**
		 * @private
		 */
		protected function verifyMethod():Boolean 
		{
			var value:String = data.method.getSpecificMetaDataArgValue(AnnotationConstants.TEST, MockolateRunnerConstants.VERIFY);
			return !value || value == "true";
		}
		
		/**
		 * @private
		 */
		override public function toString():String 
		{
			return formatToString(this, "VerifyMockInstances");
		}
	}
}