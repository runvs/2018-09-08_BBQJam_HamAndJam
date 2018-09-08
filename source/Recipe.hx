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
	public var startTime : Date;
	public var points : Int;

	public function new(IngredientArray:Array<IngredientType>, ?rewardPoints:Int=1, ?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		ingredients = IngredientArray;
		points = rewardPoints;
	}

	public function startRecipe(posX:Int, posY:Int)
	{
		this.startTime = Date.now();
		this.setPosition(posX, posY);
	}
}
