const User = require("../model/user");

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const moment = require("moment");
const OTP = require("../model/otp");
const nodemailer = require("nodemailer");

const register = async (req, res) => {
  try {
    const {
      email,
      password,
      firstName,
      lastName,
      image,
      adresse,
      phone,
      gender,
      birthDate,
    } = req.body;

    // Check if a user with the given email already exists
    const existingUser = await User.findOne({ email: email });
    if (existingUser) {
      return res.status(403).json({
        message: "User already exists",
      });
    }

    // Hash the password
    const hashedPass = await bcrypt.hash(password, 10);

    // Create and save the new user
    const user = new User({
      firstName,
      lastName,
      image,
      email,
      adresse,
      phone,
      gender,
      birthDate,
      commandHistory: [],
      password: hashedPass,
    });

    const savedUser = await user.save();
    res
      .status(201)
      .json({ message: "User added successfully", uid: savedUser.id });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
};

const login = (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  User.findOne({ email: email }).then((user) => {
    if (user) {
      bcrypt.compare(password, user.password, function (err, result) {
        if (err) {
          res.json({
            error: err,
          });
        }
        if (user.ban) {
          return res.status(401).json({
            message: "user banned",
          });
        }
        if (result) {
          let token = jwt.sign({ email: user.email }, "secretValue", {
            expiresIn: "15m",
          });
          let refreshtoken = jwt.sign(
            { name: user.firstName },
            "refreshtokensecret",
            { expiresIn: "7d" }
          );
          // Calculate the expiration date of the token
          const expirationDate = new Date();
          expirationDate.setMinutes(expirationDate.getMinutes() + 15);

          res.status(200).json({
            message: "login successful",
            token,
            refreshtoken,
            tokenExpiration: moment(expirationDate).format(
              "YYYY-MM-DD HH:mm:ss"
            ),
            Uid: user._id,
          });
        } else {
          res.status(202).json({
            message: "password does not match!",
          });
        }
      });
    } else {
      res.status(404).json({
        message: "no user found",
      });
    }
  });
};

const getUserById = async (req, res) => {
  const uid = req.params.id;
  try {
    await User.findById(uid).then(async (u) => {
      if (u) {
        res.status(200).json(u);
      } else {
        res.status(404).json({ msg: "User not Found" });
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateUser = async (req, res) => {
  const id = req.params.id;
  const firstName = req.body.firstName;
  const lastName = req.body.lastName;
  const image = req.body.image;
  const email = req.body.email;
  const adresse = req.body.adresse;
  const gender = req.body.gender;
  const birthDate = req.body.birthDate;
  const commandHistory = req.body.commandHistory;
  try {
    const userUpdated = await User.findByIdAndUpdate(
      id,
      {
        firstName: firstName,
        lastName: lastName,
        image: image,
        email: email,
        adresse: adresse,
        gender: gender,
        birthDate: birthDate,
        commandHistory: commandHistory,
      },
      { new: true }
    );
    if (!userUpdated) {
      res.status(404).json({ msg: "user not found" });
    } else {
      res.status(200).json({ msg: "user updated successfully", userUpdated });
    }
  } catch (err) {
    res.status(500).json({ msg: "user not updated", error: err.message });
  }
};

const updatepassword = async (req, res) => {
  var oldpasswordd = req.body.oldPassword;
  var newpasswordd = req.body.newPassword;
  var id = req.body.id;

  await User.findOne({ _id: id }).then(async (user) => {
    if (user) {
      bcrypt.compare(oldpasswordd, user.password, async function (err, result) {
        if (err) {
          return res.status(500).json({
            message: err,
          });
        }
        if (result) {
          bcrypt.hash(newpasswordd, 10, async function (err, newhashedPass) {
            if (err) {
              return res.status(500).json({
                message: err,
              });
            }
            await User.findOne({ _id: id }).then(async (user) => {
              if (user) {
                await User.findByIdAndUpdate(user.id, {
                  password: newhashedPass,
                });
                res.json({
                  message: "password updated suuccessful",
                });
              } else {
                return res.status(404).json({
                  message: "no user  found",
                });
              }
            });
          });
        } else {
          return res.status(202).json({
            message: "wrong password",
          });
        }
      });
    } else {
      return res.status(404).json({
        message: "no user  found",
      });
    }
  });
};

const updateUserImage = async (req, res) => {
  const uid = req.params.id;
  const updateFields = {
    image: req.body.image,
  };

  try {
    const updatedUser = await User.findByIdAndUpdate(uid, updateFields, {
      new: true,
    });
    if (!updatedUser) {
      res.status(404).json({ msg: "user not found" });
    } else {
      res.status(200).json({ msg: "image updated successfully", updatedUser });
    }
  } catch (err) {
    res.status(500).json({ msg: "image not updated" });
  }
};

const forgetPassword = async (req, res) => {
  var emaill = req.body.email;
  var random = Math.floor(1000 + Math.random() * 9000);

  await User.findOne({ email: emaill }).then(async (user) => {
    if (user) {
      let details = {
        from: "luxwatch79@gmail.com",
        to: emaill,
        subject: "Please reset your password",
        text: `We heard that you lost your application password.\n Sorry about that! But don’t worry!\n You can use the following CODE to reset your password : \n  ${random}`,
      };
      let mailTransporter = nodemailer.createTransport({
        service: "gmail",
        auth: { user: "luxwatch79@gmail.com", pass: "itmz qyub kyji tors" },
      });
      mailTransporter.sendMail(details, (err) => {
        if (err) {
          console.error("Error sending email:", err); // Corrected this line
        } else {
          console.log("Email sent successfully");
        }
      });

      let date = new Date(Date.now());
      date.setMinutes(date.getMinutes() + 15);
      let otp = new OTP({ email: emaill, otp: random, expiry_date: date });
      await OTP.findOne({ email: emaill }).then(async (oldOTP) => {
        if (!oldOTP) {
          await otp.save();
        } else {
          oldOTP.expiry_date = otp.expiry_date;
          oldOTP.otp = otp.otp;
          await OTP.findByIdAndUpdate(oldOTP.id, oldOTP);
        }
      });

      res.json({
        message: `send email  suuccessful `,
      });
    } else {
      res.status(404).json({
        message: "no email found",
      });
    }
  });
};

const VerifCode = (req, res, next) => {
  var codee = req.body.otp;
  var emaill = req.body.email;

  OTP.findOne({ $and: [{ otp: codee }, { email: emaill }] }).then((otp) => {
    if (otp) {
      let date = new Date(Date.now());
      date.setMinutes(date.getMinutes() + 0);

      if (otp.expiry_date < date) {
        return res.status(400).json({
          message: `expired code`,
        });
      } else {
        res.json({
          message: `code suuccessful`,
        });
      }
    } else {
      return res.status(404).json({
        message: "no code found ",
      });
    }
  });
};

const Resetpassword = async (req, res) => {
  var passwordd = req.body.password;
  var emaill = req.body.email;

  bcrypt.hash(passwordd, 10, async function (err, hashedPass) {
    if (err) {
      return res.status(500).json({
        message: err,
      });
    }
    await User.findOne({ email: emaill }).then(async (user) => {
      if (user) {
        await User.findByIdAndUpdate(user.id, {
          password: hashedPass,
        });
        res.json({
          message: `password updated suuccessful`,
        });
      } else {
        return res.status(404).json({
          message: "no user  found",
        });
      }
    });
  });
};

module.exports = {
  register,
  login,
  getUserById,
  updateUser,
  updatepassword,
  updateUserImage,
  Resetpassword,
  VerifCode,
  forgetPassword,
};
