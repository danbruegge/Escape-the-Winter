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

    public function move(?tiles:Int=1, ?newFacing:Int=-1):Void {
        
        var ts = tileSize * tiles;

        if (newFacing >= 0) facing = newFacing;

        switch(facing) {
            case FlxObject.UP: 
                y -= ts;
            case FlxObject.RIGHT: 
                x += ts;
            case FlxObject.DOWN: 
                y += ts;
            case FlxObject.LEFT: 
                x -= ts;
        }
    
    }

}
