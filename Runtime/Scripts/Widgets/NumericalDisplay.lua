-- Register the behaviour
behaviour("NumericalDisplay")

function NumericalDisplay:Start()
	self.digitLimit = self.targets.DataContainer.GetInt("MaxDigitLimit")
	self.zeroOpacity = self.targets.DataContainer.GetInt("ZeroOpacity")
	self.displayMax = self.targets.DataContainer.GetFloat("DisplayMax")
	self.zeroColor = self.targets.DataContainer.GetColor("ZeroColor")
	self.displayZeroes = self.targets.DataContainer.GetBool("DisplayZeroes")

	self.currentValue = 0
	self.maximumValue = 0

	local opacity = self.zeroOpacity
	local hexOpacity = string.format("%02X", opacity)
	self.opacityTag = "<alpha=#" .. hexOpacity .. ">"
end

function NumericalDisplay:SetColor(color)
	self.color = color
	self.colorRichTextTag = ColorScheme.RichTextColorTag(color)
end

function NumericalDisplay:SetValue(val)
	self.currentValue = val
	self:UpdateDisplay()
end

function NumericalDisplay:SetMaximum(val)
	self.maximumValue = val
	self:UpdateMaxDigits()
end

function NumericalDisplay:UpdateMaxDigits()
	self.maxDigits = self:GetDigits(self.maximumValue)
	if self.maxDigits > self.digitLimit then self.maxDigits = self.digitLimit end
	
	self:UpdateDisplay()
end

function NumericalDisplay:GetDigits(num)
	num = Mathf.Ceil(num)
	return (num == 0) and 1 or Mathf.Floor(Mathf.Log10(Mathf.Abs(num))) + 1
end

function NumericalDisplay:Empty()
	self.targets.Number.text = ""
end

function NumericalDisplay:UpdateDisplay()
	local val = Mathf.Ceil(self.currentValue)
	val = Mathf.Clamp(val,0,self.displayMax)

	local text = self.colorRichTextTag .. val .. "</color>"

	if self.displayZeroes then
		local digits = self:GetDigits(val)
		local numZeroes = self.maxDigits - digits
		local prefix = ""
		for i = 1, numZeroes, 1 do
			prefix = prefix .. "0"
		end

		local zeroRichTextTag = ColorScheme.RichTextColorTag(self.zeroColor)

		self.targets.Number.text = zeroRichTextTag .. self.opacityTag .. prefix .. "</color>" .. "</color>" .. text
	else
		self.targets.Number.text = text
	end
end
