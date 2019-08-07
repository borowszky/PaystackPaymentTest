package models

type NewTransferModel struct {
	Source    string `json:"source"`
	Reason    string `json:"reason"`
	Amount    string `json:"amount"`
	Recipient string `json:"recipient"`
	Reference string `json:"reference"`
}

type TransferDetail struct {
	Integration    int64         `json:"integration"`
	Recipient      RecipientInfo `json:"recipient"`
	Domain         string        `json:"domain"`
	Amount         float64       `json:"amount"`
	Currency       string        `json:"currency"`
	Source         string        `json:"source"`
	Source_details interface{}   `json:"source_details"`
	Reason         string        `json:"reason"`
	Status         string        `json:"status"`
	Failures       interface{}   `json:"failures"`
	Transfer_code  string        `json:"transfer_code"`
	Id             int64         `json:"id"`
	CreatedAt      string        `json:"createdAt"`
	UpdatedAt      string        `json:"updatedAt"`
}

type FinalizeTransferModel struct {
	Transfer_code string `json:"transfer_code"`
	Otp           string `json:"otp"`
}

type TransferCodeModel struct {
	Transfer_code string `json:"transfer_code"`
}

type BulkTransferInnerModel struct {
	Amount    float64 `json:"amount"`
	Recipient string  `json:"recipient"`
}

type BulkTransferModel struct {
	Currency  string                   `json:"currencey"`
	Source    string                   `json:"source"`
	transfers []BulkTransferInnerModel `json:"transfers"`
}

type ResendOTPForTransferModel struct {
	Transfer_code string `json:"transfer_code"`
	Reason        string `json:"reason"`
}

type FinalizeDisableOTPRequirementForTransferModel struct {
	Otp string `json:"otp"`
}
