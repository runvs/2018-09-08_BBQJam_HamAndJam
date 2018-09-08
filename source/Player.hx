package;

import flixel.FlxSprite;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite 
{
	
	private static var moveAcc : Float = 1000;

	public function new() 
	{
		super();
		
		this.makeGraphic(32, 64);
		this.animation.add("idle", [0], 8, true);
		this.animation.add("yes", [0], 8, false);
		this.animation.add("no", [0], 8, false);
		
		this.maxVelocity.set(500, 0);
		this.drag.set(3000, 3000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);

	}
	
	public function sayYes()
	{
		this.animation.play("yes");
	}
	
	public function sayNo()
	{
		this.animation.play("no");
	}
}