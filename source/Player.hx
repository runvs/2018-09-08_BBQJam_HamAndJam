package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

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
		
		this.maxVelocity.set(500, 0);
		this.drag.set(3000, 3000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (MyInput.xVal < 0 )
		{
			this.acceleration.set( -moveAcc, 0);
		}
		else if (MyInput.xVal > 0)
		{
			this.acceleration.set( moveAcc, 0);
		}
		else
			this.acceleration.set();
	}
	
}