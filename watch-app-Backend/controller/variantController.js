// const variant = require("../model/variant");

// const addVariant = async (req, res) => {
//   const newVariant = new variant(req.body);
//   try {
//     const savedVariant = await newVariant.save();
//     res.status(201).json(savedVariant);
//   } catch (err) {
//     res.status(500).json(err);
//   }
// };

// const getAllVariants = async (req, res) => {
//   try {
//     await variant.find({ watchId: req.params.id }).then(async (variants) => {
//       if (variants) {
//         res.status(200).json(variants);
//       } else {
//         res.status(404).json({ msg: "variants not found" });
//       }
//     });
//   } catch (err) {
//     res.status(500).json(err);
//   }
// };

// // const getOneVariant = async (req, res) => {
// //   try {
// //     const product = await variant.findById(req.params.id);
// //     if (!product) {
// //       return res.status(404).json({ error: "Variant not found." });
// //     }
// //     res.status(200).json(product);
// //   } catch (error) {
// //     res.status(500).json({ error: "Failed to fetch the Variant." });
// //   }
// // };

// const getOneVariant = async (req, res) => {
//   const vid = req.params.id;
//   try {
//     await variant.findById(vid).then(async (variant) => {
//       if (variant) {
//         res.status(200).json(variant);
//       } else {
//         res.status(404).json({ msg: "variant not found" });
//       }
//     });
//   } catch (err) {
//     res.status(500).json(err);
//   }
// };

// module.exports = {
//   addVariant,
//   getAllVariants,
//   getOneVariant,
// };
