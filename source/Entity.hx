package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Entity extends FlxSprite {

    public var tileSize:Int;

    override public function new(X:Float=0, Y:Float=0):Void {
    
        super(X, Y);

        tileSize = Settings.tileSize;

    }

    public function move(?newFacing:Int):Void {
        
        if (newFacing >= 0) facing = newFacing;

        switch(facing) {
            case FlxObject.UP: 
                y -= tileSize;
            case FlxObject.RIGHT: 
                x += tileSize;
            case FlxObject.DOWN: 
                y += tileSize;
            case FlxObject.LEFT: 
                x -= tileSize;
        }
    
    }

}
