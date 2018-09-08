package;
import flixel.FlxG;
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
	
	private var counter : Int = 0;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState) 
	{
		super(X, Y, s);
		this.makeGraphic(102, 96);
		ingredients = new FlxTypedGroup();
	}
	
	public function checkCanPlace (it : IngredientType) : Bool
	{
		if (ingredients.length >= 1 && ingredients.members[ingredients.length - 1].getID() == IngredientType.BUN_TOP) return false;
		
		if (it == IngredientType.BUN_BOT)
		{
			return (counter == 0);
		}
		
		if (it != IngredientType.SAUCE)
		{
			if (counter == 0) return false;
		}
		
		if ( it == IngredientType.SAUCE)
		{
			for (ii in ingredients)
			{
				var i : PlacedIngredient = ii;
				if (i.getID() == IngredientType.SAUCE) return false;
			}
			return true;
		}
		return true;
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
			counter += 1;
			var i : PlacedIngredient = new PlacedIngredient(it, x, y );
			i.offset.set(0, -( this.height - (counter * IngredientOffset) -8));
			ingredients.add(i);
		}
		else
		{
			counter += 1;
			var i : PlacedIngredient = new PlacedIngredient(it, x, y );
			i.offset.set(0, -( this.height - counter * IngredientOffset ));
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
	
	public function clearMyBurger()
	{
		for (ii in this.ingredients)
		{
			var i : PlacedIngredient = ii;
			i.destroy();
		}
		ingredients.clear();
		this.counter = 0;
	}
	
	override function onDrop() 
	{
		super.onDrop();
		
		if (FlxG.overlap(_state.rubbish, this))
		{
			clearMyBurger();
		}
		
	}
	
	
}