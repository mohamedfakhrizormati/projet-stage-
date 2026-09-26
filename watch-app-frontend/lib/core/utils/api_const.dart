class ApiConst {
  static const baseUrl = 'http://192.168.43.26:8000/api';

  //authentication apis
  static const register = '$baseUrl/register'; //create Account
  static const login = '$baseUrl/login';
  static const getOneUser = '$baseUrl/user';
  static const updateUser = '$baseUrl/updateUser';
  static const updateUserPassword = '$baseUrl/update-password';
  static const updateUserImage = '$baseUrl/updateImage';
  static const refreshToken = "$baseUrl/refreshtoken";
  static const forgetPassword = "$baseUrl/forgetPassword";
  static const verifyOTP = "$baseUrl/verifCode";
  static const resetPassword = "$baseUrl/resetPassword";

  //watchs apis
  // static const addWatch = '$baseUrl/watch/add';
  static const getAllWatchs = '$baseUrl/watchs';
  static const getOnewatch = '$baseUrl/watch';
  static const getWatchsByCat = '$baseUrl/watchCat';
  static const getSortedWatchsByCat = '$baseUrl/watchs/sorted/category';
  static const getSortedWatchsBySales = '$baseUrl/watchs/sorted/sales';
  static const getSortedWatchsByCreationDate = '$baseUrl/watchs/sorted/date';

  //category apis
  static const categories = '$baseUrl/categories';

  //command apis
  static const addCommand = '$baseUrl/addCommand';
  static const getAllCommands = '$baseUrl/commands';
  static const getOneCommand = '$baseUrl/command';
  static const updateCommandStatus = '$baseUrl/updateStatus';

  //sales apis
  static const addSales = '$baseUrl/addSales'; //create sale
  static const getAllSales = '$baseUrl/sales';
  static const getOneSale = '$baseUrl/sale';
  static const updateSales = '$baseUrl/sales';
  static const deleteSales = '$baseUrl/sales';

  //variant apis
  static const getAllVariant = '$baseUrl/variants';
  static const getOneVariant = '$baseUrl/variant';

  //cart apis
  static const addCart = '$baseUrl/addCart';
  static const getOneCart = '$baseUrl/cart';
  static const updateCart = '$baseUrl/updateCart';
  static const deleteCart = '$baseUrl/deleteCart';

  //wishlist apis
  static const createWishList = '$baseUrl/wishlist';
  static const getOneWishList = '$baseUrl/wishList';
  static const updateWishList = '$baseUrl/updateWishlist';
  static const deleteWishList = '$baseUrl/wishList/delete';
}
