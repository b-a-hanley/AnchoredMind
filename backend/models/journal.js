import mongoose from 'mongoose';

const journalSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
}, {
    timestamps: true
});

const journal = mongoose.model('journal', journalSchema);

export default journal;