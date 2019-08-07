package models

type Agent struct {
	Username string
	Password string
}

type AdminUserDetail struct {
	ID                    int64
	FirstName             string
	LastName              string
	Gender                string
	Email                 string
	Phone                 string
	PictureUrl            string
	EmailVerificationDate string
	PhoneVerificationDate string
	CreationDate          string
	CreatedBy             string
	LastEditDate          string
	LastEditedBy          string
	ActivationDate        string
	DeactivationReason    string
	ActivatedBy           string
	RoleName              string
	RoleID                int64
	Username              string
	LastLoginDate         string
	LastPasswordResetDate string
}
