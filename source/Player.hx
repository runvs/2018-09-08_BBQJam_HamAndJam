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
		
		//this.makeGraphic(32, 64, );
		this.loadGraphic(AssetPaths.Burger_guy_sheet__png, true, 125, 115);
		//this.scale.set(5, 5);
		this.animation.add("idle", [0], 8, true);
		this.animation.add("yes", [0,1,2,3,4,5,6,7,8,9], 8, false);
		this.animation.add("no", [10,11,12,13,14,15,16,17,18,19,20], 8, false);
		this.animation.play("idle");
		
		this.maxVelocity.set(500, 0);
		this.drag.set(3000, 3000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		trace(x, y);

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