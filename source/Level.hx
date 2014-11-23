package;

import flixel.FlxG;
import flixel.group.FlxTypedGroup;

class Level extends FlxTypedGroup<Sector> {

    public var sectors:Sector;

    override public function new():Void {
    
        super();

        for (i in 0...6) {
            
            add(new Sector(i));
        
        }

        FlxG.state.add(this);
    
    }

    public function next():Void {
    
        getFirstAlive().background.loadGraphic('assets/images/sector_grass.png');
        // TODO
        // ====
        // getfirstalive, reset the group to the end of it
        // getSecondAlive, and reset type to winter
        // move all sectors to another position
    
    }

}
