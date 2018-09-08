package;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Laguna
 */
class BurgerSlot extends Draggable 
{
	
	private var ingredients : FlxTypedGroup<PlacedIngredient>;
	private static var IngredientOffset : Float = 15;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState) 
	{
		super(X, Y, s);
		this.makeGraphic(102, 96);
		ingredients = new FlxTypedGroup();
	}
	
	public function addIngredientToStack (it: IngredientType)
	{
		if (it == IngredientType.SAUCE)
		{
			
			var i : PlacedIngredient = new PlacedIngredient(it, x, y );
			i.offset.set( - this.width, -( this.height -82));
			ingredients.add(i);
		}
		else if (it == IngredientType.BUN_TOP)
		{
			var size : Int = ingredients.length +1;
			var i : PlacedIngredient = new PlacedIngredient(it, x, y );
			i.offset.set(0, -( this.height - (size * IngredientOffset) -8));
			ingredients.add(i);
		}
		else
		{
			
			var size : Int = ingredients.length + 1;
			var i : PlacedIngredient = new PlacedIngredient(it, x, y );
			i.offset.set(0, -( this.height - size * IngredientOffset ));
			ingredients.add(i);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		for (ii in ingredients)
		{
			var i : PlacedIngredient = ii;
			i.setPosition(x, y);
		}
		//ingredients.update(elapsed);
		
		
		
	}
	override public function draw():Void 
	{
		super.draw();
		ingredients.draw();
	}
	
}