package;

/**
 * ...
 * @author Laguna
 */
class BurgerSlot extends Draggable 
{

	public function new(?X:Float=0, ?Y:Float=0, s:PlayState) 
	{
		super(X, Y, s);
		this.makeGraphic(64, 64);
	}
	
}