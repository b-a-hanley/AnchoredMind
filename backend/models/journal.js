import mongoose from 'mongoose';

const journalSchema = new mongoose.Schema({
    title:{
        type: String,
        required: true
    },
    mood:{
        type: String,
        required: true
    },
    input:{
        type: String,
        required: true
    },
}, {
    timestamps: true
});

const journal = mongoose.model('journal', journalSchema);

export default journal;