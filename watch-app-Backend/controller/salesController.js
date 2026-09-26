const sales = require("../model/sales");
const Watch = require("../model/watchs");

//add sales
const createSales = async (req, res) => {
  try {
    const newSales = new sales(req.body);
    const savedSales = await newSales.save();
    res.status(201).json(savedSales);
  } catch (err) {
    res.status(500).json({ msg: "error creating sales ", error: err.message });
  }
};

const getSalesById = async (req, res) => {
  const sid = req.params.id;
  try {
    const Sales = await sales.findById(sid);
    if (!Sales) {
      res.status(404).json({ msg: "sales Not Found ! " });
    } else {
      res.status(200).json(Sales);
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllSales = async (req, res) => {
  try {
    const userId = req.params.userId;
    const Sales = await sales.find();

    res.status(200).json(Sales);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updateSale = async (req, res) => {
  try {
    const sale = await sales.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });
    res.status(200).json(sale);
  } catch (error) {
    res.status(500).json({ error: "Failed to update the sale." });
  }
};

// const updateSales = async (req, res) => {
//   const sid = req.params.id;
//   const { watchId, userId, quantity, totalPrice } = req.body;
//   try {
//     const Sales = await sales.findByIdAndUpdate(
//       sid,
//       {
//         watchId: watchId,
//         userId: userId,
//         quantity: quantity,
//         totalPrice: totalPrice,
//       },
//       { new: true }
//     );
//     if (!Sales) {
//       res.status(404).json({ msg: "sales Not Found ! " });
//     } else {
//       res.status(200).json(Sales);
//     }
//   } catch (err) {
//     res
//       .status(500)
//       .json({ msg: "Error to update sales ! ", error: err.message });
//   }
// };

const deleteSales = async (req, res) => {
  const sid = req.params.id;
  try {
    const Sales = await sales.findByIdAndDelete(sid);
    if (!Sales) {
      res.status(404).json({ msg: "sales Not Found ! " });
    } else {
      res.status(200).json(Sales);
    }
  } catch (err) {
    res
      .status(500)
      .json({ msg: "Error to Delete sales ! ", error: err.message });
  }
};

const calculTotal = async (req, res) => {
  const { watchId, quantity } = req.body;

  try {
    const watch = await Watch.findById(watchId);
    if (!watch) {
      return res.status(404).json({ msg: "watch not found" });
    }

    if (quantity <= 0) {
      return res.status(400).json({ msg: "Quantity must be greater than 0" });
    }

    const totalPrice = quantity * watch.price;

    res.status(200).json({ totalPrice });
  } catch (err) {
    res
      .status(500)
      .json({ msg: "Error calculating total", error: err.message });
  }
};
module.exports = {
  createSales,
  getSalesById,
  updateSale,
  deleteSales,
  calculTotal,
  getAllSales,
};
