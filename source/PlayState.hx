package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

class PlayState extends FlxState {

    var _level:Level;
    var _player:Player;
    var _walls:FlxGroup;
    var _moveRate:Int = Settings.moveRate;

    override public function create():Void {

        super.create(); 

        FlxG.mouse.visible = false;
        FlxG.cameras.bgColor = 0x333333;

#if !debug
        FlxG.debugger.visible = true;
        FlxG.debugger.drawDebug = true;
#end

        _level = new Level();
        _player = new Player();

        _walls = FlxCollision.createCameraWall(
            FlxG.camera,
            FlxCollision.CAMERA_WALL_INSIDE,
            1
        );

        _resetTimer();

    }

    override public function update():Void {

        super.update();

        FlxG.overlap(_player, _walls, _player.gameOver);
        FlxG.overlap(_player, _level, _player.gameOver);

        if (_player.x > (Settings.tileSize * 19)) {
            
            _level.next();
        
        }

    }

    function _resetTimer(?Timer:FlxTimer) {

        if (!alive && Timer != null) {

            Timer.destroy();

            return;

        }

        new FlxTimer(_moveRate / FlxG.updateFramerate, _resetTimer);

        _player.move();

    }

}
