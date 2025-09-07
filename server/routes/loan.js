const express = require("express");
const router = express.Router();


const { protect } = require("../middleware/authMiddleware");


const {
  submitLoan,
  getLoans,
  getLoanById,
  updateLoanStatus
} = require("../controllers/loanController");


router.post("/", protect, submitLoan);
router.put("/:id/status", protect, updateLoanStatus);

router.get("/", protect, getLoans);
router.get("/:id", protect, getLoanById);

module.exports = router;
