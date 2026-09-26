const mongoose = require("mongoose");

const wishListSchema = new mongoose.Schema(
  {
    watches: [String],
    userId: { type: String, required: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("wishList", wishListSchema);
