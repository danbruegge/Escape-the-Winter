package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxSort;

class Level extends FlxTypedGroup<Sector> {

    override public function new():Void {
    
        super();

        for (i in 0...6) {
            
            var s = new Sector(i);
            s.ID = i;
            add(s);
        
        }

        FlxG.state.add(this);
    
    }

    public function next():Void {

        // TODO
        // ====
        // reorder the humans and obstacles on the sector

        // Shift all sectors except the first one, to the new position
        forEach(function (sector:Sector) {
        
            if (sector.ID > 0) {

                sector.shiftSector(Settings.sectorSize);
                sector.ID--;

            }
        
        });

        // Set the first sector at the end
        var s:Sector = getFirstAlive();
        s.shiftSector(Settings.sectorSize * 5, FlxObject.RIGHT);
        s.ID = members.length - 1;
        s.setBackground('grass');
        s.reviveHumans();

        // sort the sectors by the new IDs
        sort(sortByID);
        // set snow background to the first sector
        getFirstAlive().setBackground('snow');
    
    }

    public function sortByID(Order:Int, s1:Sector, s2:Sector) {
    
        return FlxSort.byValues(Order, s1.ID, s2.ID);
    
    }

}
