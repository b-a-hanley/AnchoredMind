import express from "express";

import { getJournals, createJournal, updateJournal, deleteJournal} from "../controllers/JournalController.js";
import { getGratitudes, createGratitude, updateGratitude, deleteGratitude} from "../controllers/GratitudeController.js";

const router = express.Router();

//Journal endpoints
router.get("/journal/entries", getJournals);
router.post("/journal/entries", createJournal);
router.put("/journal/entries/:id", updateJournal);
router.delete("/journal/entries/:id", deleteJournal);
//Gratitude endpoints
router.get("/gratitude/entries", getGratitudes);
router.post("/gratitude/entries", createGratitude);
router.put("/gratitude/entries/:id", updateGratitude);
router.delete("/gratitude/entries/:id", deleteGratitude);

export default router;