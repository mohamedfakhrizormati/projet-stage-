const mongoose = require("mongoose");
const user = require("./user");

const commandSchema = new mongoose.Schema(
  {
    userId: {
      type: String,
      required: true,
    },
    sales: [
      {
        type: String,
        required: true,
      },
    ],
    adresse: { type: String, required: true },
    reference: { type: String, required: true },
    commandTotalPrice: { type: Number, required: true },
    commandDate: { type: Date, required: true },
    commandStatus: {
      type: String,
      enum: ["paid", "shipped", "completed", "cancelled"],
      default: "pending",
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("command", commandSchema);
