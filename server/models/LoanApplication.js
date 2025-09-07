const mongoose = require("mongoose");

const loanApplicationSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",      
      required: true,
    },
    amount: {
      type: Number,
      required: true,
    },
    tenure: {
      type: Number,    
      required: true,
    },
    purpose: {
      type: String,
      default: "Personal", 
    },
    status: {
      type: String,
    enum: [
        "Submitted",
        "Under Review",
        "E-KYC",
        "E-Nach",
        "E-Sign",
        "Disbursed",
        "Rejected",
      ],
      default: "Submitted", 
    },
    approvedAmount: {
      type: Number,      
    },
    disbursedDate: {
      type: Date,        
    },
  },
  {
    timestamps: true,    
  }
);

module.exports = mongoose.model("LoanApplication", loanApplicationSchema);
