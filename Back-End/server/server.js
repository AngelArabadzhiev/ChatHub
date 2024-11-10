import express from 'express';
import express_ws from "express-ws";
import bcrypt from "bcrypt";
import {MongoClient} from 'mongodb';

const app = express();
const saltRounds = 10;
const port = 3000;
let expressWs = express_ws(app);

const uri = "mongodb://localhost:27017/";
const client = new MongoClient(uri);

let global_ws;
app.use(express.json());
app.ws("/return-ws", function (ws, req) {
    global_ws = ws;
    ws.on("message", function (msg) {
        ws.send("I agree");
    });
});
//UserName, password and email
app.post('/register', function (req, res) {
    (async () => {
        const hashedPassword = await hashPassword(req.body.password);
        insertIntoDB(req.body.username, req.body.email, hashedPassword).catch(console.dir);
    })();
    res.send("Post request received");
});

//Username and password
app.post('/login', function (req, res) {
    let username = req.body.username;

    (async () => {
        const hashedPassword = await hashAndCompare(req.body.password);
        if(hashedPassword){
            searchInDB(username, hashPassword(req.body.password)).catch(console.dir);
        }
    })();
    res.send("Post request received");
})

async function hashPassword(plainPassword) {
    try {
        return await bcrypt.hash(hash, saltRounds);
    } catch (error) {
        console.error("Error hashing password:", error);
    }
}

async function  hashAndCompare(password) {
    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (err) {
            console.error("Error hashing password:", err);
            return false;
        }
        bcrypt.compare(password, hash, (err, result) => {
            if (err) {
                console.error("Error comparing password:", err);
                return false;
            }
            if (result) {
                console.log("Password is correct!");
                return true;
            } else {
                console.log("Incorrect password.");
                return false;
            }
        });
    });
}

async function insertIntoDB(username, email, password) {
    try {
        const database = client.db('users');
        const users = database.collection('users');
        const query = {"username": username, "email": email, "password": password};
        const user = await users.insertOne(query);
    } finally {
        await client.close();
    }
}

async function searchInDB(username, password) {
    try {
        const database = client.db('users');
        const users = database.collection('users');
        const query = {"username": username, "password": password};
        const user = await users.findOne(query);
        console.log(user.body);
    } finally {
        await client.close();
    }
}

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
