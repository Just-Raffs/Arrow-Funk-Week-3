package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxBackdrop;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var clickfreddy:Int = 0;
	var bg:FlxSprite;
	var bg2:FlxSprite;
	var chess:FlxBackdrop;
	var overlay:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat2'));
		add(bg);

		bg2 = new FlxSprite().loadGraphic(Paths.image('credshit'));
		add(bg2);
		bg2.alpha = 0.5;
		

		//chess
		chess = new FlxBackdrop(Paths.image('fpbg'), 0, 0, true, false);
		chess.y -= 80;
		add(chess);
		
		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;

		overlay = new FlxSprite().loadGraphic(Paths.image('credov'));
		add(overlay);
		overlay.alpha = 1;

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Arrow Funk'],
			['Yoisabo',				'yoisabo',			'Basicamente tudo, eu tô morta, me ajuda \n*Monochrome*',												'https://twitter.com/abo_bora',				'C6297F'],
			['Roxo Depressivo',		'murasaki',			'Artista e designer de personagens',						'https://twitter.com/Roxo_Depressivo',		'441C8C'],
			['Im Not Sonic',		'sonic',			'Artista dos sprites',										'https://twitter.com/Imnotsonic1',			'4E58C4'],
			['Hiro Mizuki',			'hiro',				'Programador\nComprei arroz hoje',						'https://twitter.com/umgaynanet1',			'21ff7e'],
			['BeastlyChip',		'chip',				'Compositor \nVocê deveria pausar o jogo',		'https://twitter.com/BeastlyChip',			'03BAFE'],
			['Tio Sans',			'tiosans',			'Compositor\nEle faz umas música daora',						'https://twitter.com/NewTioSans',			'14a3c7'],
			['Tyefling',			'tyefling',			'Dublador\nEle faz umas música daora também',				'https://twitter.com/tyefling',				'3A2538'],
			[''],
			['Creditos'],
			['Idéias originais',		'jeferso',			'"MINHA IRMÃ DANDO O NOME PARA OS PERSONAGENS DE FRIDAY NIGHT FUNKIN!"',			'https://youtu.be/9MdqEWp0YC8',				'EA3CDF'],
			['Roaded64',			'roaded',			'Ele ajudou com o port da Psych ou alguma coisa assim',				'https://twitter.com/64_Roaded',			'21ff7e'],
			['Gabiss',				'gabiss',			'Criador do Kleitin',									'https://twitter.com/G_GABlS',				'83E800'],
			['Mod do Salsicha',			'shaggy',			'A música Earthquake/Terremoto foi inspirada pelo mod original do Salsicha feito pelo SrPerez\n go play shaggy mod\ntrain go train oh',				'https://gamejolt.com/games/fnf-shaggy/643999',				'2D478E'],
			[''],
			['Muito obrigada'],
			['Aizakku',				'aizakku',			'Suporte emocional <3',									'https://twitter.com/ItsAizakku',			'EA861C'],
			['Arwen Team',			'arwen',			'Amiguinhos <3',											'https://twitter.com/ArwenTeam',			'FF2400'],
			['Lightwuz, Yuumiwuz, Vsilva',				'acho',	         										'freinds (2) <3\n\nAcho que é o Lightwuz...',			'https://youtu.be/-_27xIq1pIs',			'8993FF'],
			['Shadow Mario',		'shadowmario',		'Me ajudou a entender como a Psych Engine funciona \n(Valeu aí Mario Sombroso)',							'https://twitter.com/Shadow_Mario_',	'444444'],
			[''],
			['Psych Engine Team'],
			['Shadow Mario (again)',		'shadowmario',		'Principal programador da Psych Engine',							'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'riveroaken',		'Principal artista/animadora da Psych Engine',						'https://twitter.com/RiverOaken',		'C30085'],
			['shubs',				'shubs',			'Programador adicional da Psych Engine',					'https://twitter.com/yoshubs',			'279ADC'],
			[''],
			['Former Engine Members'],
			['bb-panzu',			'bb-panzu',			'Ex-Programador da Psych Engine',							'https://twitter.com/bbsub3',			'389A58'],
			[''],
			['Engine Contributors'],
			['iFlicky',				'iflicky',			'Compositor da Psych Engine\nFez os sons de diálogo e também fez a Tea Time',	'https://twitter.com/flicky_i',			'AA32FE'],
			['SqirraRNG',			'gedehari',			'Fez as mecânicss extras do Chart Editor\n Fez a mecânica da WaveForm',						'https://twitter.com/gedehari',			'FF9300'],
			['PolybiusProxy',		'polybiusproxy',	'Extensão pro vídeo rodar em .mp4',								'https://twitter.com/polybiusproxy',	'FFEAA6'],
			['Keoiki',				'keoiki',			'Animações do Splash das notas',									'https://twitter.com/Keoiki_',			'FFFFFF'],
			['Smokey',				'smokey',			'Suporte da Spritemap texture',								'https://twitter.com/Smokey_5_',		'4D5DBD'],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programador do Friday Night Funkin'",						'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animador do Friday Night Funkin'",							'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artista do Friday Night Funkin'",							'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Compositor do Friday Night Funkin'",							'https://twitter.com/kawaisprite',		'6475F3'],
			[''],
			['freddy fazbear'],
			['freddy fazbear',		'fredy',			"feddy fazurso",											'https://youtu.be/w0h4YNI_aHI?t=65',	'63272E']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			if (curSelected == 43)
				{
					clickfreddy += 1;
				
					if (clickfreddy == 87) {
					CoolUtil.browserLoad(creditsStuff[curSelected][3]);
					}
					else
					{
					FlxG.sound.play(Paths.sound('fedy'));
					}

					if (clickfreddy >= 87) {
						
						clickfreddy = 0;
						
						}
					
				}
			if (curSelected != 43)
				{
					CoolUtil.browserLoad(creditsStuff[curSelected][3]);
				}
			
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
