const express = require("express");
const router = express.Router();

const cartController = require("../controller/cartController");

router.post("/addCart", cartController.createCart);
router.get("/cart/:id", cartController.getCartByUserId);
router.put("/updateCart/:id", cartController.updateCart);

module.exports = router;
