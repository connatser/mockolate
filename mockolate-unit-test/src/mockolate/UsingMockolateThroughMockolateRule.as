package mockolate
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	import mockolate.ingredients.Mockolatier;
	import mockolate.ingredients.mockolate_ingredient;
	import mockolate.runner.MockolateRule;
	import mockolate.sample.Flavour;
	
	import org.hamcrest.assertThat;
	
	use namespace mockolate_ingredient;

	public class UsingMockolateThroughMockolateRule
	{
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();
		
		[Mock]
		public var mockolatier:Mockolatier;
		
		[Mock]
		public var flavour:Flavour;
		
		[Before]
		public function setup():void 
		{
			// MockolateRule defaults to using the MockolatierMaster.mockolatier
			// however we can override the mockolatier that the rule uses.
			mocks.mockolatier = mockolatier;
		}
		
		[Test]
		public function prepare_shouldBeForwardedToMockolatier():void 
		{
			mocks.prepare(EventDispatcher, Sprite);
			
			assertThat(mockolatier, received().method("prepare").args(EventDispatcher, Sprite).once());
		}
		
		[Test]
		public function nice_shouldBeForwardedToMockolatier():void 
		{
			mocks.nice(Flavour);
			
			assertThat(mockolatier, received().method("nice").args(Flavour).once());
		}
		
		[Test]
		public function strict_shouldBeForwardedToMockolatier():void 
		{
			mocks.strict(Flavour);
			
			assertThat(mockolatier, received().method("strict").args(Flavour).once());
		}
		
//		[Test]
//		public function partial_shouldBeForwardedToMockolatier():void 
//		{
//			mocks.partial(Flavour);
//			
//			assertThat(mockolatier, received().method("partial").args(Flavour).once());
//		}
		
		[Test]
		public function mock_shouldBeForwardedToMockolatier():void
		{
			mocks.mock(Flavour);
			
			assertThat(mockolatier, received().method("mock").args(Flavour).once());
		}
		
		[Test]
		public function stub_shouldBeForwardedToMockolatier():void
		{
			mocks.stub(Flavour);
			
			assertThat(mockolatier, received().method("stub").args(Flavour).once());
		}
		
		[Test]
		public function verify_shouldBeForwardedToMockolatier():void
		{
			mocks.verify(Flavour);
			
			assertThat(mockolatier, received().method("verify").args(Flavour).once());
		}
		
		[Test]
		public function record_expect_expectArg_replay_shouldBeForwardedToMockolatier():void
		{
			mocks.record(flavour);
			mocks.expect(flavour.combine(mocks.expectArg(Flavour)));
			mocks.replay(flavour);
			
			assertThat(mockolatier, received().method("record").args(Flavour).once());
			assertThat(mockolatier, received().method("expectArg").args(Flavour).once());
			assertThat(mockolatier, received().method("expect").args(null).once());
			assertThat(mockolatier, received().method("replay").args(Flavour).once());
		}
	}
}