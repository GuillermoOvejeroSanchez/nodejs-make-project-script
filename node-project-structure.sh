#!/bin/bash
STRING="Insert name of project"
echo $STRING
read NAME
cd /c/dev/node-web/ #change to your current directory for node
mkdir $NAME
cd $NAME
mkdir client    #front-end  goes here
mkdir api       #back-end   goes here
cd api

touch $NAME.code-workspace
echo "{
	\"folders\": [
		{
			\"path\": \"C:\\\\dev\\\\node-web\\\\$NAME\" 
		}
	]
}" >> $NAME.code-workspace

mkdir controllers
mkdir middlewares
mkdir models
mkdir routes
mkdir services

touch app.js
touch index.js

#comment/uncomment to make node project
npm init 
npm install --save express
npm install --save bcrypt-nodejs
npm install --save body-parser
npm install --save connect-multiparty
npm install --save jwt-simple
npm install --save moment
npm install --save mongoose
npm install --save mongoose-pagination
npm install --save nodemon -d
### add/remove dependencies ###

### add initial code to index ###
echo "'use strict'

const mongoose = require('mongoose');
var app = require('./app.js'); //imports app.js

//Conexion DB
mongoose.Promise = global.Promise; //promise
mongoose.connect(app.get('db'), {
        useNewUrlParser: true
    }) 
    .then(() => {
        console.log(\"Succesfull db connection\");

        //create server
        var server = app.listen(app.get('port'), () => {
            console.log(\"Server running on port: \" + server.address().port);

        });
    })
    .catch(err => console.log(err));" >> index.js
##########################################################################################

#add initial code to app
echo "'use strict'


var express = require('express'); //HTTP methods
var bodyParser = require('body-parser'); //body parser for post methods

var app = express();

//settings
app.set('port', process.env.PORT || 3800 );
app.set('db','mongodb://localhost:27017/$NAME');
app.set('secret', 'secret');

//routes

//middlewares
app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(bodyParser.json());

//cors
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
 
    next();
});


//routes

app.get('*', (req, res) => {
    res.end('Not found');
})

//export config
module.exports = app;
" >> app.js
