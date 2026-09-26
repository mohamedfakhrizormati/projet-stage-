const category = require("../model/category");
const watch = require("../model/watchs");

//add Watch
const addWatch = async (req, res) => {
  const newWatch = new watch(req.body);
  try {
    const savedWatch = await newWatch.save();
    res.status(201).json(savedWatch);
  } catch (err) {
    res.status(500).json(err);
  }
};

const getWatchById = async (req, res) => {
  const wid = req.params.id;
  try {
    await watch.findById(wid).then(async (w) => {
      if (w) {
        res.status(200).json(w);
      } else {
        res.status(404).json({ msg: "watch not found !" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllWatchs = async (req, res) => {
  try {
    await watch.find().then(async (watchs) => {
      if (watchs) {
        res.status(200).json(watchs);
      } else {
        res.status(404).json({ msg: "watchs not found !" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getWatchByCategoryId = async (req, res) => {
  const cid = req.params.category;
  try {
    const watches = await watch.find({ category: cid }).populate("category"); // Find watches by category ID and populate category details
    if (watches.length > 0) {
      res.status(200).json(watches);
    } else {
      res.status(404).json({ msg: "No watches found for the given category!" });
    }
  } catch (err) {
    res.status(500).json({ msg: "Server error", error: err });
  }
};

const deleteWatch = async (req, res) => {
  const wid = req.params.id;
  try {
    const Watch = await watch.findByIdAndDelete(wid);
    if (!Watch) {
      return res.status(404).json({ msg: "watch not found !" });
    } else {
      res.status(200).json({ msg: "watch deleted successfully  !" });
    }
  } catch (err) {
    res.status(500).json({ msg: "Error occurred while deleting prod" });
  }
};

// Get soretd watchs by category
const getSortedWatchsByCat = async (req, res) => {
  try {
    const watchs = await watch.find().sort({ category: -1 });
    res.status(200).json(watchs);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch Watchs." });
  }
};

// Get soretd watchs
const getSortedWatchsByCreationDate = async (req, res) => {
  try {
    const watchs = await watch.find().sort({ createdAt: -1 });
    res.status(200).json(watchs);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch Watchs." });
  }
};

const getSortedWatchsBySales = async (req, res) => {
  try {
    const watchs = await watch
      .find({ saleCount: { $gt: 0 } })
      .sort({ saleCount: -1 });
    res.status(200).json(watchs);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch Watchs." });
  }
};

module.exports = {
  addWatch,
  getWatchById,
  deleteWatch,
  getAllWatchs,
  getWatchByCategoryId,
  getSortedWatchsByCat,
  getSortedWatchsByCreationDate,
  getSortedWatchsBySales,
};
