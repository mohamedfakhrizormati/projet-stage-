const express = require("express");
const router = express.Router();
const multer = require("multer");
require("dotenv").config();
const User = require("../model/user");

const authController = require("../controller/authController");

router.post("/register", authController.register);
router.post("/login", authController.login);
router.get("/user/:id", authController.getUserById);
router.put("/updateUser/:id", authController.updateUser);
router.put("/update-password", authController.updatepassword);
router.put("/updateImage/:id", authController.updateUserImage);
router.post("/forgetPassword", authController.forgetPassword);
router.post("/verifCode", authController.VerifCode);
router.post("/resetPassword", authController.Resetpassword);

filename = "";
const mystorage = multer.diskStorage({
  destination: "./uploads/images",
  filename: (req, file, redirect) => {
    let date = Date.now();
    let f1 = date + "." + file.mimetype.split("/")[1];
    redirect(null, f1);
    filename = f1;
  },
});

const upload = multer({ storage: mystorage });

router.post("/updateImage", upload.any("image"), async (req, res) => {
  var id = req.body.id;
  try {
    await User.findByIdAndUpdate(id, {
      image:
        "http://" +
        process.env.IP_ADDRESS +
        ":" +
        process.env.PORT +
        "/uploads/images/" +
        filename,
    });
    res.status(200).json({
      message: "image updated",
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
