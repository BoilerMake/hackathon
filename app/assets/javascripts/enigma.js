(function(){
  "use strict";
  /*var backingScale = function() {
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
      canvas.style.width = oldWidth + "px";
      canvas.style.height = oldHeight + "px";
    }
  };*/

  var CIRCLE = Math.PI * 2;
  var ENTERKEY = 13;
  var interval;
  var gone = 0;
  var s;
  var Enigma = {
    keys: [],
    keyCount: 0,
    colors: ['rgba(255,255,255,'],
    validChars: "0123456789ABCDEFGHIJKLMNOPQURSTUVWXYZ",
    interval: 0,
    message: "BOILERMAKE",
    messageCounter: 0,
    charPressed: '',
    canvas: 0,
    ctx: 0,
    settings: {
      amount: Math.round(window.innerWidth) * Math.round(window.innerHeight) / 22,
      width: window.innerWidth,
      height: window.innerHeight,
      size: 22,
      scaledSize: 22 * 4,
      lineWidth: 1.2,
    },
    init: function() {
      s = this.settings;
      //mobile shit ignore for now
      /*if ((s.width / s.size * .25) >= (Enigma.message.length)) {
        while ((Math.round(s.width / s.size) - Enigma.message.length) % 2 === 0) {
          s.size++;
        }
      }*/
      this.userActions();
      Enigma.canvas = document.querySelector('canvas');
      Enigma.canvas.height = s.height;
      Enigma.canvas.width = s.width;
      Enigma.ctx = Enigma.canvas.getContext("2d");
      //scaleCanvas(Enigma.ctx, Enigma.canvas);
      for (var i = 0, countX = 0; i < s.width; countX++, i += s.scaledSize) {
        Enigma.keys[countX] = [];
        for (var j = 0, countY = 0; j < s.height; countY++, j += s.scaledSize) {
          Enigma.keys[countX][countY] = new Enigma.key(i, j);
        }
      }
      Enigma.startLoop();

      window.setTimeout(function() {
        window.validSignup();
      }, 1500);
    },
    key: function(i, j) {
      this.character = Enigma.validChars.substr( Math.floor(Math.random() * 36), 1);
      this.light = 0;
      this.messageC = 0;
      this.x = i;
      this.y = j;
      this.color = Enigma.colors[i % 3];
      this.id = Enigma.keyCount++;
      this.opacity = '1.0';
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
        Enigma.ctx.arc(this.x + .5, this.y + .5, s.size, 0, CIRCLE, true);
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
          this.character = Enigma.charPressed.toUpperCase();
        }
        if (this.light > 0){
          this.light--;
        }
        if (this.messageC !== 0) {
          Enigma.ctx.fillText(this.messageC, this.x + 1, this.y + (s.size / 2.5) - 1);
        } else {
          Enigma.ctx.fillText(this.character, this.x + 1, this.y + (s.size / 2.5) - 1);
        }
      };
    },
    lightKey: function(p, delay, duration) {
      window.setTimeout(function(){
        p.light = duration;
      }, Math.random() * delay);
    },
    userActions: function() {
      window.addEventListener('resize', function() {
        s.amount = Math.round(window.innerWidth);
        s.width = window.innerWidth;
        s.height = window.innerHeight;
        Enigma.canvas = document.querySelector('canvas');
        Enigma.canvas.height = s.height;
        Enigma.canvas.width = s.width;
        Enigma.ctx = Enigma.canvas.getContext("2d");
        scaleCanvas(Enigma.ctx, Enigma.canvas);
        if ((s.width / s.size * .25) >= (Enigma.message.length)) {
          s.size = 22;
          while ((Math.round(s.width / s.size) - Enigma.message.length) % 2 == 0) {
            if (s.size < 20) {
              s.size++;
            } else {
              s.size--;
            }
          }
        } 
        var lPosition = $("form:first").position();
        var sPosition = $("h3:first").position();
        if (lPosition.top >= sPosition.top * .9) {
          $('h3').css('opacity', '0');
        } else {
          $('h3').css('opacity', '0.75');
        }
        if (gone === 0) {
          for (var i = 0; i < s.height / s.size * .35; i++) {
            Enigma.keys[i] = [];
            for (var j = 0; j < s.width / s.size * .25; j++) {
              Enigma.keys[i][j] = new Enigma.key(i, j);
            }
          }
        } else {
          for (var i = 0; i < s.height / s.size * .35; i++) {
            Enigma.keys[i] = [];
            for (var j = 0; j < s.width / s.size * .25; j++) {
              Enigma.keys[i][j] = new Enigma.key(i, j);
            }
          }
          for (i = 0; i < s.height / s.size * .35; i++) {
            for (j = 0; j < s.width / s.size * .25; j++) {
              Enigma.charPressed = ' ';
              if (i === Math.round((s.height / s.size * .35) * .5) ) {
                if ((j > Math.floor(s.width / s.size * .25 * .5) - (Enigma.message.length * .5)) && (j < Math.ceil(s.width / s.size * 0.25) * 0.5 + (Enigma.message.length * 0.5))) {
                  Enigma.messageKey(Enigma.keys[i][j], 250, 10, j);
                } else {
                  Enigma.keys[i][j].opacity = '0';

                  Enigma.lightKey(Enigma.keys[i][j], 4000, -1);
                }
              } else {
                Enigma.keys[i][j].opacity = '0';
              }
            }
          }
        }
      });
      $('#interest_signup_email').keypress(function(e) {
        var i, j;
        if (e.which !== ENTERKEY) {
          Enigma.charPressed = String.fromCharCode(e.which);
          for (i = 0; i < s.height / s.size * .35; i++) {
            for (j = 0; j < s.width / s.size * .25; j++) {
              if (Math.random() < 0.1) {
                Enigma.lightKey(Enigma.keys[i][j], 250, 10);
              } else {
                Enigma.keys[i][j].light = 0;
              }
            }
          }
        }
        return true;
      });
    },
    startLoop: function() {
      interval = window.setInterval(function() {
        Enigma.ctx.clearRect(0, 0, Enigma.canvas.width, Enigma.canvas.height);
        for (var i = 0, countX = 0; i < s.width; countX++, i += s.scaledSize) {
          for (var j = 0, countY = 0; j < s.height; countY++, j += s.scaledSize) {
            Enigma.keys[countX][countY].draw();
          }
        }
      }, 105);
    },
    stopLoop: function() {
      window.clearInterval(interval);
    },
  };

  window.validSignup = function() {
    gone = 1;
    window.setTimeout(function() {
      var flickerInterval = window.setInterval(function() {
        $('.flickerIn').each(function(index, el) {
          var n = Math.random();
          if (n > 0.67)
            $(el).css('opacity', '1');
          else if (n > 0.33)
            $(el).css('opacity', '0.5');
          else
            $(el).css('opacity', '0');
        });
      }, 105);
      window.setTimeout(function() {
        window.clearInterval(flickerInterval);
        $('.flickerIn').css('opacity', '1').removeClass('flickerIn').addClass('flickerOver');
      }, 1050);
    }, 2500);

    //Clear circles
    for (var i = 0, countX = 0; i < s.width; countX++, i += s.scaledSize) {
      for (var j = 0, countY = 0; j < s.height; countY++, j += s.scaledSize) {
        Enigma.lightKey(Enigma.keys[countX][countY], 3000, -1);
      }
    }
  };
  window.onload = function() {
    Enigma.init();
    document.getElementById('bg').className += ' fadeOut';
  };
})();
