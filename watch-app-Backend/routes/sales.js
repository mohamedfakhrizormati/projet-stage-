const express = require("express");
const router = express.Router();

const salesController = require("../controller/salesController");

router.post("/addSales", salesController.createSales);
router.get("/sale/:id", salesController.getSalesById);
router.get("/sales/:user", salesController.getAllSales);
router.put("/sales/:id", salesController.updateSale);
router.delete("/sales/:id", salesController.deleteSales);
router.post("/sales/:id", salesController.calculTotal);

module.exports = router;
