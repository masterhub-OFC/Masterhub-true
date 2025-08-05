local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- GUI principal
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "MasterHubGui"
screenGui.ResetOnSpawn = false

-- Botão flutuante
local botaoFlutuante = Instance.new("TextButton")
botaoFlutuante.Size = UDim2.new(0, 140, 0, 45)
botaoFlutuante.Position = UDim2.new(0, 20, 0.5, -22)
botaoFlutuante.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
botaoFlutuante.Text = "Master Hub"
botaoFlutuante.TextColor3 = Color3.fromRGB(255, 255, 255)
botaoFlutuante.Font = Enum.Font.GothamBold
botaoFlutuante.TextSize = 22
botaoFlutuante.Parent = screenGui
botaoFlutuante.Active = true
botaoFlutuante.Draggable = true

local roundFlutuante = Instance.new("UICorner")
roundFlutuante.CornerRadius = UDim.new(0, 10)
roundFlutuante.Parent = botaoFlutuante

-- Painel
local painel = Instance.new("Frame")
painel.Size = UDim2.new(0, 240, 0, 270)
painel.Position = UDim2.new(0, 180, 0.5, -135)
painel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
painel.Visible = false
painel.Parent = screenGui

local roundPainel = Instance.new("UICorner")
roundPainel.CornerRadius = UDim.new(0, 12)
roundPainel.Parent = painel

botaoFlutuante.MouseButton1Click:Connect(function()
	painel.Visible = not painel.Visible
end)

-- Criador de botões
local yOffset = 10
local function criarBotao(texto, cor, func)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(1, -20, 0, 40)
	botao.Position = UDim2.new(0, 10, 0, yOffset)
	yOffset += 50
	botao.BackgroundColor3 = cor
	botao.Text = texto
	botao.Font = Enum.Font.GothamSemibold
	botao.TextSize = 20
	botao.TextColor3 = Color3.new(1, 1, 1)
	botao.Parent = painel

	local round = Instance.new("UICorner")
	round.CornerRadius = UDim.new(0, 10)
	round.Parent = botao

	botao.MouseButton1Click:Connect(func)
end

-- ⬆️ Subir para cima da base (sem descer)
criarBotao("⬆️ Subir", Color3.fromRGB(0, 170, 255), function()
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	
	if humanoid then
		humanoid.PlatformStand = true
	end
	
	task.wait(0.2)
	char:SetPrimaryPartCFrame(CFrame.new(0, 85, 0))
	
	-- Trava no ar por 1 segundo e volta ao normal
	task.wait(1.2)
	if humanoid then
		humanoid.PlatformStand = false
	end
end)

-- 🏃 Speed Hack 250
local speedAtivo = false
criarBotao("🏃‍♂️ Speed Hack", Color3.fromRGB(0, 200, 0), function()
	speedAtivo = not speedAtivo
	if speedAtivo then
		RunService.RenderStepped:Connect(function()
			if speedAtivo then
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then hum.WalkSpeed = 250 end
				end
			end
		end)
	end
end)

-- 🦘 Super Pulo com JumpHeight
local puloAtivo = false
criarBotao("🦘 Super Pulo", Color3.fromRGB(255, 85, 0), function()
	puloAtivo = not puloAtivo
	if puloAtivo then
		RunService.RenderStepped:Connect(function()
			if puloAtivo then
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then
						hum.UseJumpPower = false
						hum.JumpHeight = 15
					end
				end
			end
		end)
	end
end)
	
			
	
			
