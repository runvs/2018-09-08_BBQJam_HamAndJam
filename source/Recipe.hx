package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Recipe extends FlxSprite 
{
	public var ingredients : Array<IngredientType> = new Array<IngredientType>();
	// the time when the player officially starts working on the recipe; before, it is null
	public var recipeStarted : Bool = false;
	// the time the player has to complete the recipe in seconds
	public var recipeTime : Float;
	// the time that has elapsed in the game since the recipe was begun
	private var elapsedTime : Float = 0;
	public var points : Int;

	public function new(IngredientArray:Array<IngredientType>, ?rewardPoints:Int=1, ?maxRecipeTime:Float=30.0, ?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		ingredients = IngredientArray;
		points = rewardPoints;
		recipeTime = maxRecipeTime;
	}

	public function startRecipe(posX:Int, posY:Int)
	{
		recipeStarted = true;
		this.setPosition(posX, posY);
	}

	override public function update(elapsed:Float)
	{
		if (recipeStarted)
		{
			elapsedTime+=elapsed;
		}
	}

	/*
	 * returns the seconds remaining until the recipe time is over
	 */
	public function remainingTime()
	{
		if (recipeStarted)
		{
			return recipeTime - elapsedTime;
		}
		else
		{
			return recipeTime;
		}
	}

	public function getRequiredIngredients()
	{
		return ingredients.copy();
	}
}
