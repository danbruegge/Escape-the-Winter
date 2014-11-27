package;

import flixel.FlxG;
import flixel.util.FlxRandom;

class Obstacle extends Entity {

    public var type:Int;

    override public function new(X:Float=0, Y:Float=0):Void {
    
        super(X, Y);

        // set ID to 2, to identify the obstacle
        ID = 2;
        type = FlxRandom.intRanged(8, 9);

        loadGraphic('assets/images/sprite.png', true, tileSize, tileSize);
        animation.add('grass', [type], 0, false);
        animation.add('snow', [type + 2], 0, false);
        animation.play('grass');
    
    }

}
