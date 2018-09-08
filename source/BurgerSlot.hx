package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Laguna
 */
class BurgerSlot extends Draggable 
{
	private var ingredients : FlxTypedGroup<PlacedIngredient>;
	public static var IngredientOffset : Float = 15;
	
	public var plate : FlxSprite;
	public var counter : Int = 0;
	
	public var recipe : Recipe = null;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState) 
	{
		super(X, Y, s);
		this.makeGraphic(102, 96);
		this.alpha = 0;
		ingredients = new FlxTypedGroup();
		plate = new FlxSprite();
		plate.loadGraphic(AssetPaths.plate__png);
		plate.setPosition(x, y );
		plate.offset.set(7, -(  height - plate.height + 16));
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
			
			_state.checkBurgerOk(this);
			recipe.ingredients = recipe.createRecipe();
			recipe.loadMyGraphics();
			
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
		
		plate.setPosition(x, y);
		for (ii in ingredients)
		{
			var i : PlacedIngredient = ii;
			i.setPosition(x, y);
		}
		
		var m : FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
		if (this.overlapsPoint(m))
		{
			this.alpha = 0.2;
		}
		else 
		{
			this.alpha = 0;
		}
		//ingredients.update(elapsed);
		
		
		
	}
	override public function draw():Void 
	{
		plate.draw();
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