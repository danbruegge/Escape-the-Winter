package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class Sector extends FlxTypedGroup<FlxSprite> {

    public var tileSize:Int;
    public var baseX:Int;
    public var background:FlxSprite;

    var _baseGround:String = 'grass';
    var _obstacleCount:Int;
    var _humanCount:Int;
    var _positions:Array<String>;

    override public function new(BaseX:Int=0, ?maxSize:Int=0):Void {
    
        super(maxSize);

        tileSize = Settings.tileSize;

        if (BaseX == 0) _baseGround = 'snow';

        baseX = BaseX * Settings.sectorSize;

        _obstacleCount = FlxRandom.intRanged(10, 15);
        _humanCount = FlxRandom.intRanged(1, 5);
        _positions = [];

        _createObstacles();
        _createHumans();

        _createBackground();

    }

    public function setBackground(animationName:String='grass'):Void {
    
        background.animation.play(animationName);

        forEach(function (tile:FlxSprite) {
        
            if (tile.ID == 2) {
                tile.animation.play(animationName);
            }
        
        });
    
    }

    public function shiftSector(tiles:Int, ?newFacing:Int=FlxObject.LEFT):Void {

        var ts = tileSize * tiles;
    
        forEach(function (tile:FlxSprite) {

            if (newFacing == FlxObject.RIGHT) {
                tile.x += ts;
            } else {
                tile.x -= ts;
            }
        
        });

        if (newFacing == FlxObject.RIGHT) {
            background.x = ts;
        } else {
            background.x -= ts;
        }
    
    }

    public function reviveHumans():Void {
    
        forEach(function (tile:FlxSprite) {
        
            if (tile.ID == 1 && !tile.alive) {

                tile.alive = true;
                tile.animation.play('manned');
            
            }

        });
    
    }

    function _getRandomPos():FlxPoint {
    
        var X:Int = baseX + FlxRandom.intRanged(0, 4);
        var Y:Int = FlxRandom.intRanged(1, 13);
        var pos:FlxPoint = new FlxPoint(tileSize * X, tileSize * Y);


        if (_positions.indexOf(pos.toString()) < 0) {

            _positions.push(pos.toString());

            return pos;
        
        }

        return _getRandomPos();

    }

    function _createBackground():Void {
    
        background = new FlxSprite(baseX * tileSize, 0);
        background.loadGraphic(
            'assets/images/sectors.png',
            true,
            tileSize * 5,
            tileSize * 15
        );
        background.animation.add('snow', [0], 0, false);
        background.animation.add('grass', [1], 0, false);

        FlxG.state.add(background);

        setBackground(_baseGround);

    }

    function _createObstacles():Void {

        for (i in 0..._obstacleCount) {
            
            var pos:FlxPoint = _getRandomPos();

            add(new Obstacle(pos.x, pos.y));
        
        }
    
    }

    function _createHumans():Void {
    
        for (i in 0..._humanCount) {
            
            var pos:FlxPoint = _getRandomPos();

            add(new Human(pos.x, pos.y));
        
        }
    
    }

}
