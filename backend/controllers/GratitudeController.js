import mongoose from "mongoose";
import Gratitude from "../models/gratitude.js";

export const getGratitudes = async (req, res) => {
	try {
		const gratitudes = await Gratitude.find({});
		res.status(200).json({ success: true, data: gratitudes });
	} catch (error) {
		console.log("Error in fetching gratitudes:", error.message);
		res.status(500).json({ success: false, message: "Server Error"});
	}
};

export const createGratitude = async (req, res) => {
    const gratitude = req.body;
    if(!gratitude.prompt&&!gratitude.input) {
        return res.status(400).json({success:false, message: "Provide correct details"});
    }

    const newGratitude = new Gratitude(gratitude);

    try {
        await newGratitude.save();
        res.status(201).json({ success: true, data: newGratitude });
    } catch (error) {
        console.error("Error in Create gratitude:", error.message);
        res.status(500).json({ success: false, message: "Server Error"});
    };
};

export const updateGratitude = async (req, res) => {
	const { id } = req.params;

	const gratitude = req.body;

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(404).json({ success: false, message: "Invalid Gratitude Id" });
	}

	try {
		const updatedGratitude = await Gratitude.findByIdAndUpdate(id, gratitude, { new: true });
		res.status(200).json({ success: true, data: updatedGratitude });
	} catch (error) {
		res.status(500).json({ success: false, message: "Server Error" });
	}
};

export const deleteGratitude = async (req, res) => {
	const { id } = req.params;

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(404).json({ success: false, message: "Invalid Gratitude Id" });
	}

	try {
		await Gratitude.findByIdAndDelete(id);
		res.status(200).json({ success: true, message: "Gratitude deleted" });
	} catch (error) {
		console.log("error in deleting gratitude:", error.message);
		res.status(500).json({ success: false, message: "Server Error" });
	}
};