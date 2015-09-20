<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>  
<style type="text/css">
#container {
    width: 80%;
    height: 800px;
    border: 1px solid black;
    margin-left: 100px;
}

.main{
    padding-left: 20px;
}

#length-label{
    padding-left: 14px;
    padding-bottom: 10px;
    color:#3343b0;
}

.subclass
{
    padding-bottom: 15px;
}

#calcbtn{
    color:black;
}

.units{
    background-color: #96d3ea;
}
</style>
<title>Max Cube</title>
</head>
<body>
<script src="http://www.html5canvastutorials.com/libraries/three.min.js"></script>
<div class="main" id="dimensionsNotRound" data-role="tooltip">
    <!--<label class="grid-8">Dimensions:</label>-->
    <h2 style="text-align:center; color:red"> Find Max Cube </h2>

<form action="/ramachandra/restservice" method="post">
    <div class="col-xs-12 subclass"> 
        <div>
           <h4 id="length-label">Enter Length of the Wood below &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please select units from the drop down below</h4>
            
        </div>
        
        <div class="col-xs-3">
            <input class="numeric-textbox form-control col-xs-3" name="inp-length" type="text" value="${len}"/>  
        </div>
            
       	<div class="col-xs-3">    
            <select class="form-control units" name="inp-units" id="inp1" onchange="return setValue();">            	
                <option value="Inches">Inches</option>
                <option value="Centimeters">Centimeters</option>
                <option value="Meters">Meters</option>
                <option value="Feet">Feet</option>
                <option value="Yards">Yards</option>
              
            </select>
        </div>
    </div>    
    
    <div class="col-xs-12 subclass">    
    
        <div class="col-xs-3">            
            <input type="submit" id="calcbtn" value="Calculate Result" onclick="display()">
        </div>
        <div class="col-xs-3">
            <select class="form-control units" name="output-units" id="inp">
                 <option value="Inches">Inches</option>
                  <option value="Centimeters">Centimeters</option>
                  <option value="Meters">Meters</option>
                  <option value="Feet">Feet</option>
                  <option value="Yards">Yards</option>                  
            </select>
        </div>
    </div>
    

    <div class="col-xs-12 subclass">
        <div class="col-xs-3"> <span>Side</span>
            <input class="numeric-textbox form-control" id="op-sidelen" name="op-length" type="text" value="${side}" onchange="return getValue();" /> 
        </div>

        <div class="col-xs-3"> <span>Volume</span>
            <input class="numeric-textbox form-control" name="op-vol" value="${volume}"/>
            <input type="hidden" id="op-int" value="${type}"/>
        </div>
    </div>
</form>
</div>
<div id="container" class="col-xs-12"></div>



<script>
function setValue(){
	document.getElementById("inp").value=document.getElementById("inp1").value;
	return true;
	}

function getValue(){
	document.getElementById("inp1").value=document.getElementById("op-int").value;
	document.getElementById("inp").value=document.getElementById("inp1").value;
	return true;
	}
	var shape = null;
    //Script for 3D Box
    // revolutions per second
    var angularSpeed = 0.2;
    var lastTime = 0;
    var cube = 0;
    // this function is executed on each animation frame
    function animate() {
        // update
        var time = (new Date()).getTime();
        var timeDiff = time - lastTime;
        var angleChange = angularSpeed * timeDiff * 2 * Math.PI / 1000;
        //cube.rotation.y += angleChange; //Starts Rotating Object
        lastTime = time;
        // render
        renderer.render(scene, camera);
        // request new frame
        requestAnimationFrame(function () {
            animate();
        });
    }
    // renderer
    var container = document.getElementById("container");
    var renderer = new THREE.WebGLRenderer();
    renderer.setSize(container.offsetWidth, container.offsetHeight - 4);
    container.appendChild(renderer.domElement);
    // camera
    var camera = new THREE.PerspectiveCamera(60, container.offsetWidth / container.offsetHeight, 1, 1000);
    camera.position.z = 800;
    // scene
    var scene = new THREE.Scene();
    scene.remove();
    // cube
    cube = new THREE.Mesh(new THREE.CubeGeometry(1, 1, 1), new THREE.MeshLambertMaterial({
        color: "black"
    }));
    cube.overdraw = true;
    cube.rotation.x = Math.PI * 0.1;
    cube.rotation.y = Math.PI * 0.3;
    scene.add(cube);
	//add arrow	
	
	 // add subtle ambient lighting
    var ambientLight = new THREE.AmbientLight(0xe53f60);
    scene.add(ambientLight);
    // directional lighting
    var directionalLight = new THREE.DirectionalLight(0xf00b39);
    directionalLight.position.set(1, 1, 1).normalize();
    scene.add(directionalLight);
    shape = cube;
    // start animation
    animate();

function display() {
			
//		 var d=document.getElementById('op-int').value;	
	//	 var element = document.getElementsByName('inp-units');		 
		// element.value = d;
		 //console.log(element.value);
		// document.getElementsByName('inp-units').value=d;
        var width = parseInt(document.getElementById('op-sidelen').value * 3.52),
        height = parseFloat(document.getElementById('op-sidelen').value * 3.52),
        length = parseFloat(document.getElementById('op-sidelen').value * 3.52);   
       
        
		console.log("length " + length + " height " + height + " width " + width);
    	shape.scale.x = length;
    	shape.scale.y = height;
    	shape.scale.z = width;
    	
};


<%= "display();" %>
<%= "setValue();" %>
<%= "getValue();" %>



		</script>

</body>
</html>