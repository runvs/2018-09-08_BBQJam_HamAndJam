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

	public static var beltSpeed : Float = 150;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState, it : IngredientType) 
	{
		super(X, Y, s);
		myType = it;
		TypeToGraphc();
		shouldBePosition = new FlxPoint( -100, 300);
	}
	
	
	function TypeToGraphc() 
	{

		if (myType == IngredientType.BUN_TOP)
		{
			this.loadGraphic(AssetPaths.bread_top_top__png, false);
		}
		else if (myType == IngredientType.BUN_BOT)
		{
			this.loadGraphic(AssetPaths.bread_bottom_top__png, false);
		}
		else if (myType == IngredientType.SALAD)
		{
			this.loadGraphic(AssetPaths.salad_top__png, false);
		}
		else if (myType == IngredientType.MEAT)
		{
			this.loadGraphic(AssetPaths.meat_top__png, false);
		}
		else if (myType == IngredientType.SAUCE)
		{
			this.loadGraphic(AssetPaths.sauce__png, false);
		}
		else if (myType == IngredientType.CHEESE)
		{
			this.loadGraphic(AssetPaths.cheese_top__png, false);
		}
		else
		{
			trace("WARNING: Unknown type: " + myType );
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		
		
		if (!lifted && canBeLifted)
		{
			x += beltSpeed * elapsed;
			
			var x1 : Float = 80;
			var x2 : Float = 100;
			var x3 : Float = 830;
			var x4 : Float = 860;
			if (x < x1)
			{
				this.alpha = 0;
			}
			else if (x < x2)
			{
				var v :Float = (x - x1) / (x2-x1);
				this.alpha = v;
			}
			else if (x < x3)
			{
				this.alpha = 1;
			}
			else if (x < x4)
			{
				var v = 1 - ((x - x3) / (x4 - x3));
				this.alpha = v;
			}
			else 
			{
				this.alpha = 0;
			}
			
		}
		
		if (x >= FlxG.width + 300) this.alive = false;
	}
	
	
	
	override function onDrop() 
	{
		super.onDrop();
		for (bsi in _state.burgerSlots)
		{
			var bs : BurgerSlot = bsi;
			if (FlxG.overlap(bs, this))
			{
				if (bs.checkCanPlace(this.myType))
				{
					bs.addIngredientToStack(this.myType);
					active = false;
					
				}
				
			}
			
			
		}
	}
	
}