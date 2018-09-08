package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class PlacedIngredient extends FlxSprite 
{
	private var IngredientID : IngredientType;
		

	public function new(ingrID:IngredientType, ?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		IngredientID = ingrID;
	}
	
	public function getID()
	{
		return IngredientID;
	}
}
