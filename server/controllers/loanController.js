const LoanApplication = require("../models/LoanApplication");


exports.submitLoan = async (req, res) => {
  try {
    const { amount, tenure, purpose } = req.body;

    if (!amount || !tenure) {
      return res.status(400).json({ error: "Amount and tenure are required" });
    }

   
    const loan = new LoanApplication({
      user: req.user._id,      
      amount,
      tenure,
      purpose,
      status: "Submitted",    
    });

    await loan.save();

    res.status(201).json({
      message: "Loan application submitted successfully",
      loan,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};


exports.getLoans = async (req, res) => {
  try {
    const loans = await LoanApplication.find({ user: req.user._id });
    res.json(loans);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};


exports.getLoanById = async (req, res) => {
  try {
    const loan = await LoanApplication.findById(req.params.id);

    if (!loan) return res.status(404).json({ error: "Loan not found" });


    if (loan.user.toString() !== req.user._id.toString()) {
      return res.status(403).json({ error: "Not authorized to view this loan" });
    }

    res.json(loan);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};


const STATUS_FLOW = [
  "Submitted",
  "Under Review",
  "E-KYC",
  "E-Nach",
  "E-Sign",
  "Disbursed"
];


exports.updateLoanStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;


  if (!STATUS_FLOW.includes(status)) {
    return res.status(400).json({ message: "Invalid status" });
  }

  try {
    const loan = await LoanApplication.findById(id);
    if (!loan) {
      return res.status(404).json({ message: "Loan not found" });
    }


    const currentIndex = STATUS_FLOW.indexOf(loan.status);
    const newIndex = STATUS_FLOW.indexOf(status);

    if (newIndex !== currentIndex + 1) {
      return res.status(400).json({ 
        message: `Invalid status transition from ${loan.status} to ${status}` 
      });
    }

    loan.status = status;
    await loan.save();

    res.status(200).json({
      success: true,
      message: `Loan status updated to ${status}`,
      loan,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};


