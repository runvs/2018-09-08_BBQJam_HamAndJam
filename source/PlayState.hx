package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.system.debug.watch.Tracker;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends BasicState
{
	// for reviving player
	var lastEntryID:Int;
	var lastTarget:String;	
	
	public var player : Player;
	
	public var ingredients : AdministratedList<IngredientDraggable>;
	public var burgerSlots : AdministratedList<BurgerSlot>;

	public var recipes : AdministratedList<Recipe>;

	private var testRecipe:Recipe;
	
	private static var DefaultIngredientSpawnTimer : Float = 1.5;
	private var IngredientSpawnTimer : Float = 0;
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		trace("playstate create begin");
		
		player = new Player();
		ingredients = new AdministratedList<IngredientDraggable>();
		
		//var i : IngredientDraggable = new IngredientDraggable(300, 300, this, IngredientType.SALAD);
		//ingredients.add(i);
		add(ingredients);


		burgerSlots = new AdministratedList<BurgerSlot>();
		var bs : BurgerSlot = new BurgerSlot(300, 500, this);
		burgerSlots.add(bs);
		add(burgerSlots);
		

		var testIngredient = new PlacedIngredient(IngredientType.SALAD);
		var testIngredientsList = new Array<IngredientType>();
		testIngredientsList.push(IngredientType.SALAD);
		var testRecipe = new Recipe(testIngredientsList);


		recipes = new AdministratedList<Recipe>();
		var testIngredient = new PlacedIngredient(IngredientType.SALAD);
		var testIngredientsList = new Array<IngredientType>();
		testIngredientsList.push(IngredientType.SALAD);
		testRecipe = new Recipe(testIngredientsList);
		recipes.add(testRecipe);
		testRecipe.startRecipe(10, 10);
	}

	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function drawObjects():Void 
	{
		super.drawObjects();
		player.draw();
		
	}
	
	override public function drawOverlay():Void 
	{
		
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{
		super.update(elapsed);
		MyInput.update();
		player.update(elapsed);


		if (ingredients.length() != 0)
			trace(ingredients.getList().members[0].x);
		
		IngredientSpawnTimer -= elapsed;
		if (IngredientSpawnTimer <= 0)
		{
			IngredientSpawnTimer = DefaultIngredientSpawnTimer;
			SpawnIngredient();
		}

		recipes.update(elapsed);

	}	
	
	function SpawnIngredient() 
	{
		trace("spawn");
		var arr :Array<IngredientType> = IngredientType.createAll();
		var idx : Int = FlxG.random.int(0, arr.length-1);
		
		var i : IngredientDraggable = new IngredientDraggable( 0, 300, this, arr[idx]);
		trace(ingredients.length());
		ingredients.add(i) ;
		trace(ingredients.length());
	}

}
