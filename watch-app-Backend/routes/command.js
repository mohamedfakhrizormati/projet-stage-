const express = require("express");
const router = express.Router();

const commandController = require("../controller/commandController");

router.post("/addCommand", commandController.createCommand);
router.get("/command/:id", commandController.getCommandById);
router.put("/command/:id", commandController.cancelCommand);

module.exports = router;
