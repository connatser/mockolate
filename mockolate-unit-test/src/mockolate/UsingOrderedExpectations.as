package mockolate
{
	import flash.events.Event;
	
	import mockolate.ingredients.Sequence;
	import mockolate.sample.Flavour;
	
	import org.flexunit.async.Async;

	public class UsingOrderedExpectations
	{
		public var flavourA:Flavour;
		public var flavourB:Flavour;
		
		[Before(async, timeout=10000)]
		public function prepareMockolates():void
		{
			Async.proceedOnEvent(this, prepare(Flavour), Event.COMPLETE, 10000);
		}
		
		[Test]
		public function usingOrderedExpectionsShouldPassIfInOrder():void 
		{
			var seq:Sequence = sequence("should pass");
			
			flavourA = nice(Flavour);
			flavourB = nice(Flavour);
			
			mock(flavourA).setter("ingredients").arg(["second", "third"]).once().ordered(seq);
			mock(flavourB).method("combine").args(flavourA).once().ordered(seq);
			
			flavourA.ingredients = ["second", "third"];
			flavourB.combine(flavourA);
		}
		
		[Test(expected="mockolate.errors.ExpectationError")]
		public function usingOrderedExpectationsShouldFailIfCallOutOfOrder():void 
		{
			var seq:Sequence = sequence("should fail");
			
			flavourA = nice(Flavour);
			flavourB = nice(Flavour);
			
			mock(flavourA).setter("ingredients").arg(["second", "third"]).once().ordered(seq);
			mock(flavourB).method("combine").args(flavourA).once().ordered(seq);
			
			// out-of-order
			flavourB.combine(flavourA);
			flavourA.ingredients = ["second", "third"];
			
			verify(flavourA)
			verify(flavourB);
		}
	}
}