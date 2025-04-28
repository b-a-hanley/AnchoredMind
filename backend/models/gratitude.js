import mongoose from 'mongoose';

const gratitudeSchema = new mongoose.Schema({
    prompt:{
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

const gratitude = mongoose.model('gratitude', gratitudeSchema);

export default gratitude;