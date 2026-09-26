const express = require("express");
const router = express.Router();

const watchController = require("../controller/watchController");

router.post("/watch", watchController.addWatch);
router.get("/watchs", watchController.getAllWatchs);
router.get("/watchs/sorted/category", watchController.getSortedWatchsByCat);
router.get("/watchs/sorted/sales", watchController.getSortedWatchsBySales);
router.get(
  "/watchs/sorted/date",
  watchController.getSortedWatchsByCreationDate
);
router.get("/watch/:id", watchController.getWatchById);
router.get("/watch/category/:category", watchController.getWatchByCategoryId);
router.delete("/watch/:id", watchController.deleteWatch);

module.exports = router;
