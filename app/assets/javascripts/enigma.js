/*DONT LOOK AT THE GOD DAMN JAVSCRIPT YET, I KNOW IT'S NOT DONE :) */


window.onload = function() {
  var canvas = document.querySelector('canvas');
  var ctx = canvas.getContext("2d");
  colors = ['rgba(230, 73, 73,', 'rgba(236, 214, 103,', 'rgba(143, 112, 97,']
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  ctx.width = canvas.width;
  ctx.height = canvas.height;
  //var particleWin = Math.round(canvas.width);
  var color = "#303030";
  var count = 0;
  var count2 = 0;
  ctx.lineWidth = 1.2;
  var count3 = 0;
  var count4 = 0;
  var testColor = 0;
//  var velX = [];
  //var startingX = canvas.width;
  //var startingY = canvas.height;
  var groundLevel = canvas.height;
  var leftWall = canvas.width * .01;
  //var rightWall = canvas.width;
  var amount = Math.round(canvas.width);
  //var velY = [];
  var particles = [],
  particleIndex = 0;

  function drawCanvas() {
    canvas.height = window.innerHeight;
    canvas.width = window.innerWidth;
    ctx.height = canvas.height;
    ctx.width = canvas.width;
    leftWall = canvas.width * .01;
    groundLevel = canvas.height * .01;
  }

  function Particle() {
    var chars = "0123456789ABCDEFGHIJKLMNOPQURSTUVWXYZ";
    this.letter = chars.substr( Math.floor(Math.random() * 36), 1);
    this.size = 22;
    var num = Math.floor(window.innerWidth / this.size);
    if (count2 == num) {
      count2 = 0;
      count3++;
      //this.x = (this.size*2) + (4*count2*this.size);
      //this.y = (this.size*2) + (this.size * 3 * count3);
    } else {
      this.x =  (this.size * 1.3) + (4*count2*this.size);
      this.y = -(this.size*.3) + (this.size * 3 * count3);
      count2++;
      this.color = colors[count3 % 3];
    }


    //this.y = (this.size*2);
    /*var ran = Math.random();
    if (ran < .2) {
      this.size = 30;
    } else {
      this.size = 30;
    }*/
    //this.vx = (Math.floor(Math.random() * 201)-100) * .01 * .2;
    //this.vy = (Math.floor(Math.random() * 201)-100) * .01 * .2;
    particleIndex++;
    particles[particleIndex] = this;
    this.id = particleIndex;
    count++;
    //this.ctpercent = 1.0;
  }
// Velocities are fucking up, refactor/fix this god damn code
Particle.prototype.draw = function() {
  //this.x += this.vx;
  //this.y += this.vy;

  ctx.clearRect(leftWall, groundLevel, canvas.width, canvas.height);    
  ctx.beginPath();
  ctx.fillStyle = color;
  if (count4%Math.floor(window.innerWidth / this.size)==0) {
    if (testColor==3) {
      testColor = 0;
    } else {
      testColor++;
    }
      //ctx.strokeStyle = 'rgba(230, 73, 73, .35)';
    } else {
      //ctx.strokeStyle = 'rgba(236, 214, 103, .35)';

    }

    if (Math.random() < 0.03) {
          if (this.color == colors[0] || this.color == colors[2]) {
      var opacity = '.50';
    } else {
      var opacity = '.40';
    }

    } else {
          if (this.color == colors[0] || this.color == colors[2]) {
      var opacity = '.30';
    } else {
      var opacity = '.20';
    }

    }




    ctx.strokeStyle = this.color + opacity + ')';
    ctx.arc(this.x+.5, this.y+.5, this.size, 0, Math.PI*2, true);
    ctx.closePath();
    ctx.stroke();

    ctx.font = '14pt code_boldregular';
    ctx.fillStyle = this.color + opacity + ')';
    if (Math.random() > .5) {
      var chars = "0123456789ABCDEFGHIJKLMNOPQURSTUVWXYZ";
      this.letter = chars.substr( Math.floor(Math.random() * 36), 1);
    }
    ctx.fillText(this.letter, this.x-(this.size/4.5), this.y+(this.size/2.5));
    if (count4 == (Math.floor(window.innerWidth / this.size * 4) / Math.floor(window.innerHeight / this.size )) ) {
      count4 = 0;
    } else {
      count4++;
    }
  }

  for (var i = 0; i < amount; i++) {
    new Particle();
  }
  /*for (var i in particles) {
    particles[i].draw();
  }*/

  setInterval(function() {
    ctx.fillStyle = "#2A2A2A";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    for (var i in particles) {
      particles[i].draw();
    }
  }, 105);



};




