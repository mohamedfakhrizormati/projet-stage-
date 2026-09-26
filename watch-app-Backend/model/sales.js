const mongoose = require("mongoose");

const salesSchema = new mongoose.Schema(
  {
    watchId: {
      type: String,
      required: true,
    },
    userId: {
      type: String,
      required: true,
    },
    quantity: { type: Number, required: true },
    totalPrice: { type: Number, required: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("sales", salesSchema);
