(function(){
  "use strict";
  window.isMobile = function() {
    var check = false;
    (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))check = true})(navigator.userAgent||navigator.vendor||window.opera);
    return check;
  }

  var backingScale = function() {
    if ('devicePixelRatio' in window) {
      if (window.devicePixelRatio > 1) {
        return window.devicePixelRatio;
      }
    }
    return 1;
  };
  var scaleCanvas = function(ctx, canvas){
    var scaleFactor = backingScale(ctx);
    if (scaleFactor > 1) {
      var oldWidth = canvas.width;
      var oldHeight = canvas.height;
      canvas.width = canvas.width * scaleFactor;
      canvas.height = canvas.height * scaleFactor;
      // update the context for the new canvas scale
      canvas.getContext("2d").scale(scaleFactor, scaleFactor);
      canvas.style.width = "100%";
      canvas.style.height = "100%";
    }
  };
  var flickerOver = function(){
    $('.flickerIn').css('opacity', '1').removeClass('flickerIn').addClass('flickerOver');
    $('#scrollBtn').removeAttr("style");
  }
  var CIRCLE = Math.PI * 2;
  var gone = 0;
  var s;
  var loadFullAnimation = true;
  var Enigma = {
    keys: [],
    keyCount: 0,
    validChars: "0123456789ABCDEFGHIJKLMNOPQURSTUVWXYZ",
    interval: 0,
    canvas: 0,
    ctx: 0,
    settings: {
      width: window.innerWidth,
      height: window.innerHeight,
      size: 22,
      scaledSize: 22 * 4,
      lineWidth: 1.2,
    },
    init: function() {
      s = this.settings;
      Enigma.canvas = document.querySelector('canvas');
      Enigma.canvas.height = s.height;
      Enigma.canvas.width = s.width;
      Enigma.ctx = Enigma.canvas.getContext("2d");
      scaleCanvas(Enigma.ctx, Enigma.canvas);
      for (var i = 0, countX = 0; i <= s.width; countX++, i += s.scaledSize) {
        Enigma.keys[countX] = [];
        for (var j = 0, countY = 0; j <= s.height; countY++, j += s.scaledSize) {
          Enigma.keys[countX][countY] = new Enigma.key(i, j);
        }
      }
      //Start canvas drawing
      var coreLoop = Enigma.startLoop();
      window.setTimeout(function() {
        //Wait for specified time to begin fadeout
        window.fader(coreLoop);
      }, 1500);
      this.userActions(coreLoop);
    },
    key: function(i, j) {
      this.character = Enigma.validChars.substr( Math.floor(Math.random() * 36), 1);
      this.light = 0;
      this.x = i;
      this.y = j;
      this.color = 'rgba(255,255,255,';
        this.id = Enigma.keyCount++;
        this.opacity = '1.0';
      //draw the individual circle
      this.draw = function() {
        if (this.light === -1){ return; }
        if (this.opacity !== '0') {
          if (Math.random() < 0.03) {
            this.opacity = '1';
          } else {
            this.opacity = '.6';
          }
        }
        Enigma.ctx.textAlign = 'center';
        Enigma.ctx.lineWidth = s.lineWidth;
        Enigma.ctx.beginPath();
        Enigma.ctx.strokeStyle = this.color + this.opacity + ')';
        Enigma.ctx.arc(this.x, this.y, s.size, 0, CIRCLE, true);
        Enigma.ctx.closePath();
        if (!this.light){
          Enigma.ctx.stroke();
        }
        Enigma.ctx.font = '14pt source-code-pro, Source Code Pro, sans-serif';
        Enigma.ctx.fillStyle = this.color + this.opacity + ')';
        if (Math.random() > .5) {
          this.character = Enigma.validChars.substr( Math.floor(Math.random() * 36), 1);
        }
        if (this.light > 0 && this.light !== Math.floor(Math.random() * 10)) {
          Enigma.ctx.fillStyle = this.color + this.opacity + ')';
          Enigma.ctx.fill();
          Enigma.ctx.fillStyle = this.color;
        }
        if (this.light > 0){
          this.light--;
        }
        Enigma.ctx.fillText(this.character, this.x + 1, this.y + (s.size / 2.5) - 1);
    };
  },
  lightKey: function(p, delay, duration) {
    window.setTimeout(function(){
      p.light = duration;
    }, Math.random() * delay);
  },
  userActions: function(coreLoop) {
    window.addEventListener('resize', function() {
      if (Enigma && Enigma.resizeEvent(coreLoop));
    });
  },
  resizeEvent: function(coreLoop) {
    s.width = window.innerWidth;
    s.height = window.innerHeight;
    Enigma.canvas.height = s.height;
    Enigma.canvas.width = s.width;
    Enigma.ctx = Enigma.canvas.getContext("2d");
    scaleCanvas(Enigma.ctx, Enigma.canvas);
    for (var i = 0, countX = 0; i <= s.width; countX++, i += s.scaledSize) {
      Enigma.keys[countX] = [];
      for (var j = 0, countY = 0; j <= s.height; countY++, j += s.scaledSize) {
        Enigma.keys[countX][countY] = new Enigma.key(i, j);
      }
    }
    if (gone === 1) {
      window.fader(coreLoop);
    }
  },
  startLoop: function() {
    return window.setInterval(function() {
      //continue drawing them
      Enigma.ctx.clearRect(0, 0, Enigma.canvas.width, Enigma.canvas.height);
      for (var i = 0, countX = 0; i <= s.width && countX < Enigma.keys.length; countX++, i += s.scaledSize) {
        for (var j = 0, countY = 0; j <= s.height && countY < Enigma.keys[countX].length; countY++, j += s.scaledSize) {
          Enigma.keys[countX][countY].draw();
        }
      }
    }, 105);
  },
  stopLoop: function(flickerInterval, coreInterval) {
    Enigma.keys = [];
    window.clearInterval(coreInterval);
    window.clearInterval(flickerInterval);
    Enigma.canvas = null;
    Enigma = null;
  },
};
  //fader for logo/circles
  window.fader = function(coreInterval) {
    gone = 1;
    var maxCircleTime = 3000;
    var flickerDelay = 500;
    var flickerStart = maxCircleTime - flickerDelay;
    var flickerDuration = 1050;
    // Circles start dissappearing at
    // t = 0
    // and will all be gone by
    // t = maxCircleTime
    // -------------------
    // Flickering will start at flickerStart and will last for
    // flickerDuration. At this point stopLoop is called with the flicker
    // setInterval handle
    window.setTimeout(function() {
      var flickerInterval = window.setInterval(function() {
          $('.flickerIn').each(function(index, el) {
            var n = Math.random();
            if (n > 0.67){
              $(el).css('opacity', '1');
            } else if (n > 0.33){
              $(el).css('opacity', '0.5');
            } else{
              $(el).css('opacity', '0');
            }
          });
      }, 105);
      window.setTimeout(function() {
        Enigma.stopLoop(flickerInterval, coreInterval);
        flickerOver();
      }, flickerDuration);
    }, flickerStart);

    //Clear circles
    for (var i = 0, countX = 0; i <= s.width; countX++, i += s.scaledSize) {
      for (var j = 0, countY = 0; j <= s.height; countY++, j += s.scaledSize) {
        Enigma.lightKey(Enigma.keys[countX][countY], maxCircleTime, -1);
      }
    }
  };
  window.onload = function() {
    // console.log(window.isMobile());
    /*if (!window.shouldSkipIntro && !window.isMobile()){
      Enigma.init();
    }
    document.getElementById('bg').className += ' fadeOut';
    if (window.shouldSkipIntro || window.isMobile()){
      flickerOver();
    }*/
  };
})();
