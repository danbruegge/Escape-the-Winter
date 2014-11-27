package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.group.FlxSpriteGroup;

import flixel.FlxState;

class Player extends Entity {

    public var body:FlxSpriteGroup;

    var _headPoints:Array<FlxPoint>;
    var _headFacings:Array<Int>;
    var _moves:Array<Int> = Settings.moves;

    override public function new(X:Float=0, Y:Float=0) {
    
        super(X, Y);

        loadGraphic('assets/images/sprite.png', true, tileSize, tileSize);
        animation.add('u', [0], 6, false);
        animation.add('r', [1], 6, false);
        animation.add('d', [2], 6, false);
        animation.add('l', [3], 6, false);

        setPosition(tileSize, tileSize);

        facing = FlxObject.RIGHT;
        animation.play('r');

        _headPoints = [FlxPoint.get(x, y)];
        _headFacings = [facing];
        body = new FlxSpriteGroup();
        for (i in 0...3) {
            _addBodySegment();
            move();
        }

        FlxG.state.add(this);
        FlxG.state.add(body);
    
    }

    override public function update():Void {
        
        super.update();

        FlxG.collide(this, body, gameOver);
        
        _controls();
    
    }

    override public function move(?tiles:Int=1, ?newFacing:Int=-1):Void {
    
        _headPoints.unshift(FlxPoint.get(x, y));

        if (_headPoints.length >= body.members.length) {

            _headPoints.pop();

        }

        super.move(tiles, newFacing);

        _headFacings.unshift(facing);

        if (_headFacings.length >= body.members.length) {
        
            _headFacings.pop();
        
        }

        for (i in 0..._headPoints.length) {

            body.members[i].setPosition(_headPoints[i].x, _headPoints[i].y);

            switch (_headFacings[i]) {
                case FlxObject.UP: body.members[i].animation.play('u');
                case FlxObject.RIGHT: body.members[i].animation.play('r');
                case FlxObject.DOWN: body.members[i].animation.play('d');
                case FlxObject.LEFT: body.members[i].animation.play('l');
            }

        }


    }

    /*
     * Shift the player and the body n tiles to the right. Here it is ignoring
     * the facing option.
     */
    public function shift(tiles:Int=1, ?newFacing:Int=-1):Void {
    
        // need to store the old facing, to reset it after the shift
        var oldFacing:Int = facing;
        
        // need to +1 the tiles..
        var ts = tileSize * (tiles + 1);

        move(tiles, newFacing);

        // shift the body
        for (i in 0..._headPoints.length) {
            _headPoints[i].x -= ts;
            body.members[i].x -= ts;
        }

        // reset old facing
        facing = oldFacing;

    }

    public function gameOver(s1:FlxSprite, s2:FlxSprite):Void {
    
        if (s2.ID == 1) {

            if (s2.alive) {
            
                _addBodySegment();
                s2.kill();

                return;

            }

        } else {
        
            FlxG.resetState();
        
        }

    
    }

    function _controls():Void {
    
        if (FlxG.keys.anyPressed(['UP']) && facing != _moves[2]) {

            facing = _moves[0];
            animation.play('u');

        } else if (FlxG.keys.anyPressed(['RIGHT']) && facing != _moves[3]) {

            facing = _moves[1];
            animation.play('r');

        } else if (FlxG.keys.anyPressed(['DOWN']) && facing != _moves[0]) {

            facing = _moves[2];
            animation.play('d');

        } else if (FlxG.keys.anyPressed(['LEFT']) && facing != _moves[1]) {

            facing = _moves[3];
            animation.play('l');

        }

        if (FlxG.keys.anyPressed(['SPACE'])) {

            FlxG.resetState();

        }
    
    }

    function _addBodySegment():Void {

        var bs:FlxSprite = new FlxSprite(-tileSize, -tileSize);
        bs.loadGraphic('assets/images/sprite.png', true, tileSize, tileSize);
        bs.animation.add('u', [4], 6, false);
        bs.animation.add('r', [5], 6, false);
        bs.animation.add('d', [6], 6, false);
        bs.animation.add('l', [7], 6, false);

        bs.animation.play('r');

        body.add(bs);

    }

}
