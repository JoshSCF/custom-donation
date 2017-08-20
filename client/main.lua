local sP = script.Parent
local input = sP.input
local don = sP['donate-btn']
local conf = true
local plrn = sP.Parent.Parent.Parent.Parent.Name
local donam = 0;
local ms = game:GetService("MarketplaceService")
local nxt = false
local max=1e6
local HB=game:GetService"RunService".RenderStepped

local ns = {500000,100000,50000,20000,10000,6000,5000,2000,1000,500,200,100,50,20,10,5,2,1}
local ns1 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

local ns2 = {
	[500000]=[[insertdevprodid]],
	[100000]=[[insertdevprodid]],
	[50000]=[[insertdevprodid]],
	[20000]=[[insertdevprodid]],
	[10000]=[[insertdevprodid]],
	[6000]=[[insertdevprodid]],
	[5000]=[[insertdevprodid]],
	[2000]=[[insertdevprodid]],
	[1000]=[[insertdevprodid]],
	[500]=[[insertdevprodid]],
	[200]=[[insertdevprodid]],
	[100]=[[insertdevprodid]],
	[50]=[[insertdevprodid]],
	[20]=[[insertdevprodid]],
	[10]=[[insertdevprodid]],
	[5]=[[insertdevprodid]],
	[2]=[[insertdevprodid]],
	[1]=[[insertdevprodid]]
} -- dev prod. ids should be *numbers*, not strings

input.Changed:Connect(function()
	conf = tonumber(input.Text) ~= nil
	if conf and #input.Text < 12 and tonumber(input.Text) > 0 and tonumber(input.Text)<=max then
		input.BorderColor3 = Color3.fromRGB(0, 255, 0)
		don.Visible = true
		donam = tonumber(input.Text)
		ns1 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	else
		input.BorderColor3 = Color3.fromRGB(255, 0, 0)
		don.Visible = false
	end
end)

don.MouseButton1Click:Connect(function()
	if not tonumber(input.Text) or tonumber(input.Text)>max then return end
	don.Visible = false
	local rep=0
	for i, v in pairs(ns) do
		while donam >= tonumber(v) do
			rep=(rep+1)%(max/100)
			if rep==0 then
				HB:Wait()
			end
			ns1[i] = ns1[i] + 1
			donam = donam - tonumber(v)
		end
	end
	for i, v in pairs(ns1) do
		--print(ns[i],v)
		for j = 1, v do
			ms:PromptProductPurchase(game.Players[plrn], tonumber(ns2[ns[i]]))
			repeat wait() until nxt
			nxt = false
			wait(1)
		end
	end
end)

ms.PromptProductPurchaseFinished:Connect(function()
	nxt = true
	--print(true)
end)
