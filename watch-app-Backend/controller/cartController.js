const Cart = require("../model/cart");

//add cart
const createCart = async (req, res) => {
  const newCart = new Cart(req.body);
  try {
    const savedCart = await newCart.save();
    res.status(201).json(savedCart);
  } catch (err) {
    res.status(500).json(err);
  }
};

const getCartByUserId = async (req, res) => {
  const uid = req.params.id;
  try {
    await Cart.findOne({ userId: uid }).then(async (cart) => {
      if (cart) {
        res.status(200).json(cart);
      } else {
        res.status(404).json({ msg: "cart not found" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateCart = async (req, res) => {
  const id = req.params.id;
  const sales = req.body.sales;

  try {
    const updatedCart = await Cart.findByIdAndUpdate(
      id,
      {
        sales: sales,
      },
      { new: true }
    );
    res.status(200).json(updatedCart);
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = { createCart, getCartByUserId, updateCart };
