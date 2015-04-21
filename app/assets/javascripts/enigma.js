var s,
Enigma = {
  keys: [],
  keyCount:  0,
  colors: ['rgba(230, 73, 73,', 'rgba(199, 181, 88,', 'rgba(143, 112, 97,'],
  validChars: "0123456789ABCDEFGHIJKLMNOPQURSTUVWXYZ",
  interval: 0,
  charPressed: '',
  canvas: 0,
  ctx: 0,
  settings: {
    amount: Math.round(window.innerWidth),
    width: window.innerWidth,
    height: window.innerHeight,
    size: 22,
    lineWidth: 1.2
  },
  init: function() {
    s = this.settings;
    this.userActions();
    Enigma.canvas = document.querySelector('canvas');
    Enigma.canvas.height = s.height;
    Enigma.canvas.width = s.width;
    Enigma.ctx = Enigma.canvas.getContext("2d");
    for (var i = 0; i < s.height/s.size; i++) {
      Enigma.keys[i] = [];
      for (var j = 0; j < s.width/s.size; j++) {
        Enigma.keys[i][j] = new Enigma.key(i, j);
      }
    }
    Enigma.startLoop();
  },
  key: function(i, j) {
    this.character = Enigma.validChars.substr( Math.floor(Math.random() * 36), 1);
    this.light = 0;
    this.x =  (s.size * 1.3) + (4 * j * s.size);
    this.y = -(s.size * .3) + (s.size * 3 * i);
    this.color = Enigma.colors[i % 3];
    this.id = Enigma.keyCount++;
    this.opacity = '1.0';
    this.draw = function() {
      if (this.light === -1) return;
      if (Math.random() < 0.03) {
        this.opacity = '.5';
      } else {
        this.opacity = '.3';
      }
      Enigma.ctx.textAlign = 'center';
      Enigma.ctx.lineWidth = s.lineWidth;
      Enigma.ctx.beginPath();
      Enigma.ctx.strokeStyle = this.color + this.opacity + ')';
      Enigma.ctx.arc(this.x+.5, this.y+.5, s.size, 0, Math.PI*2, true);
      Enigma.ctx.closePath();
      if (!this.light) Enigma.ctx.stroke();
      Enigma.ctx.font = '14pt code_boldregular';
      Enigma.ctx.fillStyle = this.color + this.opacity + ')';
      if (Math.random() > .5) {
        this.character = Enigma.validChars.substr( Math.floor(Math.random() * 36), 1);
      }
      if (this.light > 0 && this.light != Math.floor(Math.random()*10)) {
        Enigma.ctx.fillStyle = this.color + this.opacity + ')';
        Enigma.ctx.fill();
        Enigma.ctx.fillStyle = this.color;
        this.character = Enigma.charPressed;
      }
      if (this.light > 0) this.light--;
      Enigma.ctx.fillText(this.character, this.x+1, this.y+(s.size/2.5)-1);
    };
  },
  lightKey: function(p, delay, duration) {
    window.setTimeout(function(){ 
      p.light = duration;
    }, Math.random() * delay);
  },
  userActions: function() {
    window.addEventListener('resize', function() {
      //Enigma.stopLoop();
      console.log("Resized window");
      s.amount = Math.round(window.innerWidth);
      s.width = window.innerWidth;
      s.height = window.innerHeight;
      Enigma.canvas = document.querySelector('canvas');
      Enigma.canvas.height = s.height;
      Enigma.canvas.width = s.width;
      Enigma.ctx = Enigma.canvas.getContext("2d");
      for (var i = 0; i < s.height/s.size; i++) {
        Enigma.keys[i] = [];
        for (var j = 0; j < s.width/s.size; j++) {
          Enigma.keys[i][j] = new Enigma.key(i, j);
        }
      }
    });

    $('#email').keypress(function(e) {
      if (e.which === 13) {
        $('#logo').css('display', 'none');
         for (var i = 0; i < s.height/s.size; i++) {
          for (var j = 0; j < s.width/s.size; j++) {
            Enigma.charPressed = ' ';
            Enigma.lightKey(Enigma.keys[i][j], 4000, -1);
          }
        }
        } else {
          Enigma.charPressed = String.fromCharCode(e.which);
          for (var i = 0; i < s.height/s.size; i++) {
            for (var j = 0; j < s.width/s.size; j++) {
              if (Math.random() < 0.1) {
                Enigma.lightKey(Enigma.keys[i][j], 250, 10);
              } else {
                Enigma.keys[i][j].light = 0;
              }
            }
          }
        }
    });
  },
  startLoop: function() {
    interval = window.setInterval(function() {
      Enigma.ctx.clearRect(0, 0, Enigma.canvas.width, Enigma.canvas.height);
      for (var i = 0; i < s.height/s.size; i++) {
        for (var j = 0; j < s.width/s.size; j++) {
          Enigma.keys[i][j].draw();
        }
      }
    }, 105);
  },
  stopLoop: function() {
    window.clearInterval(interval);
  },

};

window.onload = function() {
  Enigma.init();
}



