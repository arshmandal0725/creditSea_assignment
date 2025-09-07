const User = require("../models/User");       
const generateOtp = require("../utils/otp"); 
const jwt = require("jsonwebtoken");


let otpStore = {};


const generateToken = (userId) => {
  return jwt.sign({ id: userId }, process.env.JWT_SECRET, {
    expiresIn: "7d", 
  });
};



exports.sendOtp = async (req, res) => {
  try {
    console.log("sendOtp function called");        // ✅ Logs every hit
    console.log("Request body:", req.body);        // ✅ Logs the incoming data

    const { phone } = req.body;
    if (!phone) {
      return res.status(400).json({ error: "Phone number required" });
    }

    const otp = generateOtp(4);   
    otpStore[phone] = otp;       

    console.log(`OTP generated for ${phone}: ${otp}`); // ✅ Logs OTP

    res.json({ message: "OTP sent successfully", otp });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};


exports.verifyOtp = async (req, res) => {
  try {
    const { phone, otp, name, dob, gender, pan, email } = req.body;

    if (!phone || !otp) {
      return res.status(400).json({ error: "Phone & OTP required" });
    }

    if (otpStore[phone] !== otp) {
      return res.status(400).json({ error: "Invalid OTP" });
    }

    let user = await User.findOne({ phone });
    let isNewUser = false;

    if (!user) {
      user = new User({ phone, name, dob, gender, pan, email });
      await user.save();
      isNewUser = true; // newly created user
    }

    // Remove OTP after verification
    delete otpStore[phone];

    const token = generateToken(user._id);

    // Determine if profile exists (check required fields)
    const profileExists = !!user.name; // true if profile is filled

    res.json({
      message: "OTP verified",
      token,
      user,
      profileExists, // <-- this tells Flutter whether to go to Home or PersonalDetails
      isNewUser,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};


exports.updateProfile = async (req, res) => {
  try {
    const { name, dob, gender, pan, email } = req.body;

    const user = await User.findById(req.user.id);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }


    if (name) user.name = name;
    if (dob) user.dob = dob;
    if (gender) user.gender = gender;
    if (pan) user.pan = pan;
    if (email) user.email = email;

    await user.save();

    res.json({
      message: "Profile updated successfully",
      user,
    });
  } catch (err) {
    console.error("Update Profile Error:", err);
    res.status(500).json({ error: "Server error" });
  }
};


exports.getProfile = async (req, res) => {
  try {
   
    const user = await User.findById(req.user.id);
    if (!user) return res.status(404).json({ error: "User not found" });

    res.json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
