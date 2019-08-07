package models

type RecipientInfo struct {
	Integration    int64           `json:"integration"`
	Domain         string          `json:"domain"`
	Type           string          `json:"type"`
	Currency       string          `json:"currency"`
	Name           string          `json:"name"`
	Details        RecipientDetail `json:"details"`
	Description    string          `json:"description"`
	Metadata       string          `json:"metadata"`
	Recipient_code string          `json:"recipient_code"`
	Active         bool            `json:"active"`
	Id             int64           `json:"id"`
	CreatedAt      string          `json:"createdAt"`
	UpdatedAt      string          `json:"updatedAt"`
}

type RecipientDetail struct {
	Account_number string `json:"account_number"`
	Account_name   string `json:"account_name"`
	Bank_code      string `json:"bank_code"`
	Bank_name      string `json:"bank_name"`
}

type NewRecipientModel struct {
	Type               string `json:"type"`
	Name               string `json:"name"`
	Description        string `json:"description,omitempty"`
	Account_number     string `json:"account_number"`
	Bank_code          string `json:"bank_code"`
	Currency           string `json:"currency"`
	Metadata           string `json:"metadata,omitempty"`
	Authorization_code string `json:"authorization_code,omitempty"`
}

type UpdateRecipientModel struct {
	Recipient_code_or_id string          `json:"recipient_code_or_id"`
	Domain               string          `json:"domain"`
	Type                 string          `json:"type"`
	Currency             string          `json:"currency"`
	Name                 string          `json:"name"`
	Details              RecipientDetail `json:"details"`
	Metadata             string          `json:"metadata"`
	Description          string          `json:"description"`
}

type DeleteRecipientModel struct {
	Recipient_code_or_id string `json:"recipient_code_or_id"`
}

type BankDetail struct {
	Name       string `json:"name"`
	Slug       string `json:"slug"`
	Code       string `json:"code"`
	Longcode   string `json:"longcode"`
	Gateway    string `json:"gateway"`
	Active     bool   `json:"active"`
	Is_deleted bool   `json:"is_deleted"`
	Id         int64  `json:"id"`
	CreatedAt  string `json:"createdAt"`
	UpdatedAt  string `json:"updatedAt"`
}
