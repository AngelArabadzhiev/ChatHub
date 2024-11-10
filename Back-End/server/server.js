import express from 'express';
import express_ws from 'express-ws';
import bcrypt from 'bcrypt';
import {MongoClient} from 'mongodb';
import dotenv from 'dotenv';

dotenv.config();
const app = express();
const saltRounds = 10;
const port = process.env.PORT;
let expressWs = express_ws(app);
const uri = process.env.MONGODB_URI;
const client = new MongoClient(uri);
let global_ws;
app.use(express.json());

app.ws('/return-ws', function (ws, req) {
    global_ws = ws;
    ws.on('message', function (msg) {
        ws.send('I agree');
    });
});

app.post('/register', async (req, res) => {
    const {username, email, password} = req.body;
    try {
        const existingUser = await findUserByUsernameOrEmail(username, email);
        if (existingUser) {
            return res.status(400).send("Username or email is already taken");
        }
        const hashedPassword = await hashPassword(password);
        await insertIntoDB(username, email, hashedPassword);
        res.status(201).send('Successfully registered');
    } catch (error) {
        console.error("Registration failed:", error);
        res.status(500).send("Error registering user");
    }
});

app.post('/login', async (req, res) => {
    const {username, password} = req.body;
    try {
        const user = await searchInDB(username);
        if (user && await bcrypt.compare(password, user.password)) {
            res.status(200).send("User login successfully");
        } else {
            res.status(401).send("Incorrect username or password");
        }
    } catch (error) {
        console.error("Login failed:", error);
        res.status(500).send("Error during login");
    }
});

async function hashPassword(password) {
    try {
        return await bcrypt.hash(password, saltRounds);
    } catch (error) {
        console.error("Error hashing password:", error);
        throw error;
    }
}

async function insertIntoDB(username, email, password) {
    try {
        await client.connect();
        const database = client.db('users');
        const users = database.collection('users');
        const query = {username, email, password};
        await users.insertOne(query);
    } finally {
        await client.close();
    }
}

async function searchInDB(username) {
    try {
        await client.connect();
        const database = client.db('users');
        const users = database.collection('users');
        const query = {username};
        return await users.findOne(query);
    } finally {
        await client.close();
    }
}
async function findUserByUsernameOrEmail(username, email) {
    try {
        await client.connect();
        const database = client.db('users');
        const users = database.collection('users');
        const query = {$or: [{username}, {email}]};
        const user = await users.findOne(query);
        return user;
    } finally {
        await client.close();
    }
}

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
