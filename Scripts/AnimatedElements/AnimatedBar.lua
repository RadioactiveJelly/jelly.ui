-- Register the behaviour
behaviour("AnimatedBar")

function AnimatedBar:Initialize(initialValue,maxValue)
	self.maxValue = maxValue
	self.currentValue = initialValue

	self.currentScale = self.currentValue/self.maxValue
	self.barToAnimate = nil

	self.animationSpeed = self.targets.DataContainer.GetFloat("AnimationSpeed")

	self:SnapToValue(self.currentValue)
end

function AnimatedBar:SnapToValue(val)
	self.currentValue = val

	self.currentScale = self.currentValue/self.maxValue

	self.targets.Fill.fillAmount = self.currentScale
	self.targets.NegativeFill.gameObject.SetActive(false)
	self.targets.PositiveFill.gameObject.SetActive(false)

	self.isAnimating = false
end

function AnimatedBar:SetValue(val)
	local previousValue = self.currentValue
	local previousScale = self.currentScale

	self.currentValue = val
	self.currentScale = self.currentValue/self.maxValue
	self.isAnimating = previousValue ~= self.currentValue
	if not self.isAnimating then return end

	if previousValue > self.currentValue then
		self.targets.Fill.fillAmount = self.currentScale
		self.targets.PositiveFill.gameObject.SetActive(false)
		self.targets.PositiveFill.fillAmount = self.currentScale
		self.targets.NegativeFill.gameObject.SetActive(true)
		self.targets.NegativeFill.fillAmount = previousScale
		self.barToAnimate = self.targets.NegativeFill
	elseif previousValue < self.currentValue then
		self.targets.NegativeFill.gameObject.SetActive(false)
		self.targets.PositiveFill.gameObject.SetActive(true)
		self.targets.PositiveFill.fillAmount = self.currentScale
		self.targets.Fill.fillAmount = previousScale
		self.barToAnimate = self.targets.Fill
	end
end

function AnimatedBar:SetMaxValue(val)
	self.maxValue = val
	self:SetValue(self.currentValue)
end

function AnimatedBar:LateUpdate()
	if not self.isAnimating then return end
	if self.barToAnimate == nil then return end

	self.isAnimating = not self:UpdateBarToAnimate()
end

function AnimatedBar:UpdateBarToAnimate()
	local targetScale = self.currentScale
	local currentFill = self.barToAnimate.fillAmount

	--if targetScale == currentFill then return false end

	--local delta = self.animationSpeed * Time.deltaTime
	--local direction = (targetScale > currentFill) and 1 or -1
	--self.barToAnimate.fillAmount = self.barToAnimate.fillAmount + delta * direction
	currentFill = Mathf.MoveTowards(currentFill, targetScale, self.animationSpeed * Time.deltaTime)
	self.barToAnimate.fillAmount = currentFill

	local hasReachedTarget = Mathf.Abs(currentFill - targetScale) < 0.001
	if hasReachedTarget then
		currentFill = targetScale
	end

	return hasReachedTarget
end
