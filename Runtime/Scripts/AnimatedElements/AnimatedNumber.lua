--A script that animates a TMPRO_UGUI object to the given value.
behaviour("AnimatedNumber")

function AnimatedNumber:Awake()
	self.value = 0
	self.displayValue = 0

	self.animationSpeed = 2.5
end

--Snap the number to the given value
function AnimatedNumber:SnapToValue(val)
	self.value = val
	self.displayValue = val

	self.targets.Number.text = self.value
	self.isAnimating = false
end

--Animate towards the given value
function AnimatedNumber:SetValue(val)
	self.value = val

	self.isAnimating = true
end

function AnimatedNumber:Reset()
	self.value = 0
	self.displayValue = 0
end

function AnimatedNumber:LateUpdate()
	if not self.isAnimating then return end

	self.isAnimating = not self:AnimateToValue()
end

function AnimatedNumber:AnimateToValue()
	local target = self.value
	local current = self.displayValue

	self.displayValue = Mathf.Ceil(Mathf.Lerp(self.displayValue, target, self.animationSpeed * Time.deltaTime))
	self.targets.Number.text = self.displayValue

	local hasReachedTarget = Mathf.Abs(current - target) < 0.001
	if hasReachedTarget then
		current = target
	end

	return hasReachedTarget
end