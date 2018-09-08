package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Laguna
 */
class HappyFaces extends FlxObject 
{
	
	public var counter: Int = 0;
	private var faces : Array<FlxSprite>;

	public function new() 
	{
		super();
		faces = new Array<FlxSprite>();
		for (i in 0 ...3)
		{
			var f : FlxSprite = new FlxSprite(20 + 64 * i, 20);
			//f.makeGraphic(60, 60, true );
			f.loadGraphic(AssetPaths.customer_ui__png, true, 53, 47);
			f.animation.add("ok", [0], 30, true);
			f.animation.add("no", [1], 30, true);
			faces.push(f);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		for (f in faces)
		{
			f.update(elapsed);
		}
	}
	
	override public function draw():Void 
	{
		super.draw();
		for (f in faces)
		{
			f.draw();
		}
	}
	
	public function Fail()
	{
		if (counter >= faces.length - 1) return;
		trace("fail");
		//faces[counter].color = FlxColor.RED;
		faces[counter].animation.play("no",true);
		counter++;
	}
	
}