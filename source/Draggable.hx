package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Draggable extends FlxSprite 
{
	
	public var lifted : Bool = false;
	public var canBeLifted : Bool = true;
	private var pickupPoint : FlxPoint;
	private var pickupOffset : FlxPoint;
	
	private var _state : PlayState;
	
	public var pickupCallbacks : Array< Void -> Void>;
	public var dropCallbacks : Array< Void -> Void>;

	public function new(?X:Float=0, ?Y:Float=0, s: PlayState) 
	{
		super(X,Y);
		_state = s;
		//this.makeGraphic(64, 64);
		pickupPoint = new FlxPoint(0, 0);
		pickupCallbacks = new Array<Void -> Void>();
		dropCallbacks = new Array<Void -> Void>();
	}
	
	
	private function onPickup()
	{
		for (cb in pickupCallbacks)
		{
			cb();
		}
	}
	
	private function onDrop()
	{
		for (cb in dropCallbacks)
		{
			cb();
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		//trace("update");
		
		super.update(elapsed);
		
		
		if (canBeLifted && ! lifted)
		{
			if (FlxG.mouse.justPressed)
			{
				var p : FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				if (this.overlapsPoint(p))
				{
					lifted = true;
					pickupPoint = new FlxPoint(x, y);
					pickupOffset = new FlxPoint(x - FlxG.mouse.x, y - FlxG.mouse.y);
					onPickup();
				}
			}
		}
		
		if (lifted)
		{
			this.setPosition(FlxG.mouse.x + pickupOffset.x, FlxG.mouse.y + pickupOffset.y);
			if (FlxG.mouse.justReleased)
			{
				lifted = false;
				onDrop();
				// todo return to pickup point
			}
		}
	}
	
}