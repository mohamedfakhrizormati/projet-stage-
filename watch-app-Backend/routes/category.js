const express = require("express");
const router = express.Router();

const categoryController = require("../controller/categorycontroller");

router.post("/category", categoryController.addCategory);
router.get("/category/:id", categoryController.getCategoryById);
router.get("/categories", categoryController.getAllCategorys);
router.delete("/category/:id", categoryController.deleteCategory);

module.exports = router;
