package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
//import flixel.group.FlxGroup.FlxTypedGroup;
//import flixel.group.FlxSpriteGroup;
//import flixel.math.FlxPoint;
//import flixel.math.FlxVector;
//import flixel.system.debug.watch.Tracker;
import flixel.text.FlxText;
//import flixel.tweens.FlxTween;
//import flixel.ui.FlxButton;
import flixel.util.FlxColor;


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
	
	public var rubbish : FlxSprite;
	
	public var score : Int = 0;
	private var scoreText : FlxText;
	private var burgerIcon : FlxSprite;
	private var happy : HappyFaces;
	
	private var belt : FlxSprite;
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		//trace("playstate create begin");
		
		belt = new FlxSprite(120, 207);
		belt.loadGraphic(AssetPaths.Forderband_v__png, true, 160, 25);
		belt.animation.add("idle", [0,1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10, true);
		belt.animation.play("idle");
		belt.origin.set();
		belt.scale.set(5, 5);
		
		add(belt);
		
		player = new Player();
		player.setPosition(500, 430);
		add(player);
		
		
		
		ingredients = new AdministratedList<IngredientDraggable>();
		
		//var i : IngredientDraggable = new IngredientDraggable(300, 300, this, IngredientType.SALAD);
		//ingredients.add(i);
		add(ingredients);

		
		rubbish = new FlxSprite(900, 650);
		rubbish.loadGraphic(AssetPaths.rubbish__png, false);
		add(rubbish);

		burgerSlots = new AdministratedList<BurgerSlot>();
		{
			var bs1 : BurgerSlot = new BurgerSlot(140, 430, this);
			burgerSlots.add(bs1);
		}
		{
			var bs : BurgerSlot = new BurgerSlot(340, 430, this);
			burgerSlots.add(bs);
		}
		{
			var bs : BurgerSlot = new BurgerSlot(590, 430, this);
			burgerSlots.add(bs);
		}
		{
			var bs : BurgerSlot = new BurgerSlot(790, 430, this);
			burgerSlots.add(bs);
		}
		add(burgerSlots);

		var testIngredient = new PlacedIngredient(IngredientType.SALAD);
		var testIngredientsList = new Array<IngredientType>();
		testIngredientsList.push(IngredientType.SALAD);
		var testRecipe = new Recipe(testIngredientsList);


		recipes = new AdministratedList<Recipe>();
		{
			testRecipe = new Recipe(null);
			recipes.add(testRecipe);
			testRecipe.startRecipe(170, 600);
		}
		{
			testRecipe = new Recipe(null);
			recipes.add(testRecipe);
			testRecipe.startRecipe(350, 600);
		}
		{
			testRecipe = new Recipe(null);
			recipes.add(testRecipe);
			testRecipe.startRecipe(610, 600);
		}
		{
			testRecipe = new Recipe(null);
			recipes.add(testRecipe);
			testRecipe.startRecipe(790, 600);
		}
		add(recipes);
		
		for (i in 0...burgerSlots.length())
		{
			var bs : BurgerSlot = burgerSlots.getList().members[i];
			bs.recipe = recipes.getList().members[i];
		}
		
		scoreText = new FlxText(1024 - 70, 30, 70, "",24);
		scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		
		burgerIcon = new FlxSprite(1024 - 70 - 60, 20);
		burgerIcon.loadGraphic(AssetPaths.burger_counter__png, false);
		
		happy = new HappyFaces();
		
		var testIngredient = new PlacedIngredient(IngredientType.SALAD);
		//var testIngredientsList = new Array<IngredientType>();
		//testIngredientsList.push(IngredientType.SALAD);
		var testingx = [
					IngredientType.BUN_BOT,
					IngredientType.SALAD,
					IngredientType.CHEESE,
					IngredientType.BUN_TOP];
		var testings = [
					new PlacedIngredient(IngredientType.BUN_BOT),
					new PlacedIngredient(IngredientType.SALAD),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.BUN_TOP)];
					   
		var checkings1 = [
					new PlacedIngredient(IngredientType.BUN_BOT),
					new PlacedIngredient(IngredientType.SALAD),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.CHEESE)];

		var checkings2 = [
					new PlacedIngredient(IngredientType.BUN_BOT),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.BUN_TOP)];

		var checkings3 = [
					new PlacedIngredient(IngredientType.BUN_BOT),
					new PlacedIngredient(IngredientType.SALAD),
					new PlacedIngredient(IngredientType.SALAD),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.BUN_TOP)];

		var checkings4 = [
					new PlacedIngredient(IngredientType.BUN_BOT),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.CHEESE),
					new PlacedIngredient(IngredientType.BUN_TOP)];

		var testRec0 = new Recipe(testingx);
		trace("should work:"+testRec0.getIngredientsFinished(testings));
		trace("should fail (no top bun):"+testRec0.getIngredientsFinished(checkings1));
		trace("should fail (not finished):"+testRec0.getIngredientsFinished(checkings2));
		trace("should fail (too many):"+testRec0.getIngredientsFinished(checkings3));
		trace("should fail (wrong ingredients):"+testRec0.getIngredientsFinished(checkings4));

		testRecipe = new Recipe();//testIngredientsList);
		recipes.add(testRecipe);
		recipes.add(new Recipe());
		recipes.add(new Recipe());
		recipes.add(new Recipe());
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
		
	}
	
	override public function drawOverlay():Void 
	{
		burgerIcon.draw();
		scoreText.draw();
		happy.draw();
	}
	
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{
		super.update(elapsed);
		scoreText.text = Std.string(score);
		scoreText.update(elapsed);
		

		//if (ingredients.length() != 0)
			//trace(ingredients.getList().members[0].x);
		
		IngredientSpawnTimer -= elapsed;
		if (IngredientSpawnTimer <= 0)
		{
			IngredientSpawnTimer = DefaultIngredientSpawnTimer;
			SpawnIngredient();
		}

		recipes.update(elapsed);
		happy.update(elapsed);
		
		if (happy.counter >= 3)
			EndGame();

	}	
	
	public function checkBurgerOk(bs:BurgerSlot) 
	{
		// TODO
		
		//FlxTween.tween(
		bs.clearMyBurger();
		happy.Fail();
		score++;
	}
	
	function SpawnIngredient() 
	{
		trace("spawn");
		
		
		var arr :Array<IngredientType> = IngredientType.createAll();
		var idx : Int = FlxG.random.int(0, arr.length-1);
		var zeroBurgerSlots : Int = 0;
		for (i in burgerSlots)
		{
			var bs : BurgerSlot = i;
			if (bs.counter == 0)
			zeroBurgerSlots++;
		}
		if (zeroBurgerSlots >= 3)
		{
			idx = 1;
		}
		else if (zeroBurgerSlots <= 2)
		{
			if (idx == 1 && FlxG.random.bool())
			{
				idx == 0;
			}
		}
		else if (zeroBurgerSlots == 0)
		{
			if (idx == 1)
			{
				idx = FlxG.random.int(0, arr.length - 1, [1]);
			}
		}
		
		
		var i : IngredientDraggable = new IngredientDraggable( -100, 240, this, arr[idx]);
		trace(ingredients.length());
		ingredients.add(i) ;
		trace(ingredients.length());
	}

}
