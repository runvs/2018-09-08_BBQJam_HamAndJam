package;

/**
 * ...
 * @author Laguna
 */
class IngredientDraggable extends Draggable 
{
	public var myType : IngredientType;

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState, it : IngredientType) 
	{
		super(X, Y, s);
		myType = it;
	}
	
}