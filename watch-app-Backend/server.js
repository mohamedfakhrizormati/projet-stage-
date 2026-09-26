const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");

const watchRoute = require("./routes/watch");
const categoryRoute = require("./routes/category");
const wishListRoute = require("./routes/wishList");
const cartRoute = require("./routes/cart");
const salesRoute = require("./routes/sales");
const authRoute = require("./routes/auth");
// const variantRoute = require("./routes/variant");
const commandRoute = require("./routes/command");

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors({ origin: "*" }));
app.use("/uploads/images", express.static("uploads/images"));

mongoose
  .connect("mongodb://localhost:27017/Watch-App-mobile", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("Connected to MongoDB"))
  .catch((err) => console.error("Error connecting to MongoDB:", err));

app.listen(8000, () => {
  console.log(`server run on port ${8000}`);
});

app.use("/api", authRoute);
app.use("/api", watchRoute);
app.use("/api", categoryRoute);
app.use("/api", wishListRoute);
app.use("/api", cartRoute);
// app.use("/api", variantRoute);
app.use("/api", salesRoute);
app.use("/api", commandRoute);
