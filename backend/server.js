import express from 'express'
import dotenv from "dotenv";
import mongoose from 'mongoose';
import router from './router.js';
import cors from 'cors';

dotenv.config();
const connectDB = async () => {
    try {
        const connect = await mongoose.connect(process.env.MONGO_URI)
        console.log(`Database connected: ${connect.connection.host}`);
    } catch (error) {
        console.error(error)
    }
};

const app = express();
app.use(cors())
const port = 9000;

app.use(express.json());
app.use("/", router);

app.listen(port, () => {
    connectDB();
    console.log(`AnchoredMind listening on port ${port}`)
})