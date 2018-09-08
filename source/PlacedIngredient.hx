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
		TypeToGraphic();
	}
	
	public function getID()  : IngredientType
	{
		return IngredientID;
	}
	
	private function TypeToGraphic()
	{
		if (IngredientID == IngredientType.BUN_TOP)
		{
			this.loadGraphic(AssetPaths.bread_top_front__png, false);
		}
		else if (IngredientID == IngredientType.BUN_BOT)
		{
			this.loadGraphic(AssetPaths.bread_bottom_front__png, false);
		}
		else if (IngredientID == IngredientType.SALAD)
		{
			this.loadGraphic(AssetPaths.salad_front__png, false);
		}
		else if (IngredientID == IngredientType.MEAT)
		{
			this.loadGraphic(AssetPaths.meat_front__png, false);
		}
		else if (IngredientID == IngredientType.SAUCE)
		{
			this.loadGraphic(AssetPaths.sauce__png, false);
		}
		else if (IngredientID == IngredientType.CHEESE)
		{
			this.loadGraphic(AssetPaths.cheese_front__png, false);
		}
		else
		{
			trace("WARNING: Unknown type: " + IngredientID );
		}
	}
}
