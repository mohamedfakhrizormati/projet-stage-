const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    image: { type: String },
    email: { type: String, required: true },
    adresse: { type: String, required: true },
    phone: { type: String, required: true },
    gender: {
      type: String,
      required: true,
      enum: ["Male", "Female"],
      default: "",
    },
    birthDate: { type: Date, required: true },
    commandHistory: [
      {
        type: String,
      },
    ],
    password: { type: String, required: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("user", userSchema);
