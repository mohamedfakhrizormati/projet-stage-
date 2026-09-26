const Category = require("../model/category");

// create
const addCategory = async (req, res) => {
  const newCategory = new Category(req.body);
  try {
    const savedCategory = await newCategory.save();
    res.status(201).json(savedCategory);
  } catch (err) {
    res.status(500).json(err);
  }
};

const getCategoryById = async (req, res) => {
  var pid = req.params.id;
  try {
    await Category.findById(pid).then(async (category) => {
      if (category) {
        res.status(200).json(category);
      } else {
        res.status(404).json({ msg: "category not found" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllCategorys = async (req, res) => {
  try {
    await Category.find().then(async (Categorys) => {
      if (Categorys) {
        res.status(200).json(Categorys);
      } else {
        res.status(404).json({ msg: "Categorys not found" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleteCategory = async (req, res) => {
  var id = req.params.id;

  try {
    const category = await Category.findByIdAndDelete(id);
    if (!category) {
      return res.status(404).json({ message: "category not found" });
    } else {
      res.status(200).json({ message: "category deleted successfully" });
    }
  } catch (error) {
    res.status(500).json({ message: "Error occurred while deleting prod" });
  }
};

module.exports = {
  addCategory,
  getCategoryById,
  deleteCategory,
  getAllCategorys,
};
