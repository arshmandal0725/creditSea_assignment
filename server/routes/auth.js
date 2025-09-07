const express = require("express");
const router = express.Router();
const { sendOtp, verifyOtp, updateProfile, getProfile } = require("../controllers/authController");
const { protect } = require("../middleware/authMiddleware");


router.post("/send-otp", sendOtp);
router.post("/verify-otp", verifyOtp);
router.post("/update-profile", protect, updateProfile);

router.get("/profile", protect, getProfile);

module.exports = router;
