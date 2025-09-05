--An bar will animate a value is assigned.
--If the value is lower than the previous value, the bar's main fill will snap to the value while a negative fill animates towards it
--If the value is higher than the previous value, a positive fill will snap to the value while the main fill will animate towards it
behaviour("AnimatedBar")

--Initialize the bar.
--initialValue: The initial value of the bar
--maxValue: The max value of the bar
function AnimatedBar:Initialize(initialValue,maxValue)
	self.maxValue = maxValue
	self.currentValue = initialValue

	self.currentScale = self.currentValue/self.maxValue
	self.barToAnimate = nil

	self.animationSpeed = self.targets.DataContainer.GetFloat("AnimationSpeed")

	self:SnapToValue(self.currentValue)
end

--Snaps the fill to the given value
function AnimatedBar:SnapToValue(val)
	self.currentValue = val

	self.currentScale = self.currentValue/self.maxValue

	self.targets.Fill.fillAmount = self.currentScale
	self.targets.NegativeFill.gameObject.SetActive(false)
	self.targets.PositiveFill.gameObject.SetActive(false)

	self.isAnimating = false
end

--Animates towards the given value
function AnimatedBar:SetValue(val)
	local previousValue = self.currentValue
	local previousScale = self.currentScale

	self.currentValue = val
	self.currentScale = self.currentValue/self.maxValue
	self.isAnimating = previousValue ~= self.currentValue
	if not self.isAnimating then return end

	if previousValue > self.currentValue then
		--If the new value is less than previous value, snap the main fill to the current value
		--Snap the negative fill to the previous value, then set it to be animated by the script 
		self.targets.Fill.fillAmount = self.currentScale
		self.targets.PositiveFill.gameObject.SetActive(false)
		self.targets.PositiveFill.fillAmount = self.currentScale
		self.targets.NegativeFill.gameObject.SetActive(true)
		self.targets.NegativeFill.fillAmount = previousScale
		self.barToAnimate = self.targets.NegativeFill
	elseif previousValue < self.currentValue then
		--If the new value is greater than previous value, snap the positive fill to the current value
		--Snap the main fill to the previous value, then set it to be animated by the script 
		self.targets.NegativeFill.gameObject.SetActive(false)
		self.targets.PositiveFill.gameObject.SetActive(true)
		self.targets.PositiveFill.fillAmount = self.currentScale
		self.targets.Fill.fillAmount = previousScale
		self.barToAnimate = self.targets.Fill
	end
end

--Sets the max value to the given value
function AnimatedBar:SetMaxValue(val)
	self.maxValue = val
	self:SetValue(self.currentValue)
end

function AnimatedBar:LateUpdate()
	if not self.isAnimating then return end
	if self.barToAnimate == nil then return end

	self.isAnimating = not self:UpdateBarToAnimate()
end

--Animate the bar that needs to be updated towards the target value
function AnimatedBar:UpdateBarToAnimate()
	local targetScale = self.currentScale
	local currentFill = self.barToAnimate.fillAmount

	currentFill = Mathf.MoveTowards(currentFill, targetScale, self.animationSpeed * Time.deltaTime)
	self.barToAnimate.fillAmount = currentFill

	local hasReachedTarget = Mathf.Abs(currentFill - targetScale) < 0.001
	if hasReachedTarget then
		currentFill = targetScale
	end

	return hasReachedTarget
end
