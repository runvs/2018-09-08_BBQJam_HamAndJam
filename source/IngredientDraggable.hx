package;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author Laguna
 */
class IngredientDraggable extends Draggable 
{
	public var myType : IngredientType;
	
	public var shouldBePosition : FlxPoint;
	public var age : Float = 0;
	
	public static var beltSpeed : Float = 50;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState, it : IngredientType) 
	{
		super(X, Y, s);
		myType = it;
		TypeToGraphc();
		shouldBePosition = new FlxPoint( -100, 300);
	}
	
	
	function TypeToGraphc() 
	{
		if (myType == IngredientType.SALAD)
		{
			this.makeGraphic(64, 64, FlxColor.GREEN);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		age += elapsed;
		
		
		if (!lifted && canBeLifted)
		{
			x += beltSpeed * elapsed;
		}
	}
	
	
	
	override function onDrop() 
	{
		super.onDrop();
		for (bsi in _state.burgerSlots)
		{
			var bs : BurgerSlot = bsi;
			if (FlxG.overlap(bs, this))
			{
				bs.addIngredientToStack(this.myType);
				active = false;
				
			}
			
			
		}
	}
	
}