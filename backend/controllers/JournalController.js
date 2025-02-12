import mongoose from "mongoose";
import Journal from "../models/journal.js";

export const getJournals = async (req, res) => {
	try {
		const journals = await Journal.find({});
		res.status(200).json({ success: true, data: journals });
	} catch (error) {
		console.log("Error in fetching journals:", error.message);
		res.status(500).json({ success: false, message: "Server Error"});
	}
};

export const createJournal = async (req, res) => {
    const journal = req.body;
    if(!journal.name) {
        return res.status(400).json({success:false, message: "Provide correct details"});
    }

    const newJournal = new Journal(journal);

    try {
        await newJournal.save();
        res.status(201).json({ success: true, data: newJournal });
    } catch (error) {
        console.error("Error in Create journal:", error.message);
        res.status(500).json({ success: false, message: "Server Error"});
    };
};

export const updateJournal = async (req, res) => {
	const { id } = req.params;

	const journal = req.body;

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(404).json({ success: false, message: "Invalid Journal Id" });
	}

	try {
		const updatedJournal = await Journal.findByIdAndUpdate(id, journal, { new: true });
		res.status(200).json({ success: true, data: updatedJournal });
	} catch (error) {
		res.status(500).json({ success: false, message: "Server Error" });
	}
};

export const deleteJournal = async (req, res) => {
	const { id } = req.params;

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(404).json({ success: false, message: "Invalid Journal Id" });
	}

	try {
		await Journal.findByIdAndDelete(id);
		res.status(200).json({ success: true, message: "Journal deleted" });
	} catch (error) {
		console.log("error in deleting journal:", error.message);
		res.status(500).json({ success: false, message: "Server Error" });
	}
};