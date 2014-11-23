package;

import flixel.FlxG;
import flixel.util.FlxRandom;

class Human extends Entity {

    public var type:Int;
    public var manned:Bool;

    override public function new(X:Float=0, Y:Float=0):Void {
    
        super(X, Y);

        // set ID to 1, to identify the human on player collision
        ID = 1;
        type = FlxRandom.intRanged(12, 13);
        manned = true;

        loadGraphic('assets/images/sprite.png', true, tileSize, tileSize);
        animation.add('manned', [type], 0, false);
        animation.add('unmanned', [type + 2], 0, false);
        animation.play('manned');

    }

    override public function kill():Void {
    
        alive = false;
        animation.play('unmanned');
    
    }

}
