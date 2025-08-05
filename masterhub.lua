local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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
painel.Size = UDim2.new(0, 240, 0, 320)
painel.Position = UDim2.new(0, 180, 0.5, -160)
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
local yOffset = 50
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

-- Subir/Descer
local plataformaAtiva = false
local plataforma
local botaoSubir

local function atualizarBotaoSubir()
	if botaoSubir then botaoSubir:Destroy() end

	botaoSubir = Instance.new("TextButton")
	botaoSubir.Size = UDim2.new(1, -20, 0, 40)
	botaoSubir.Position = UDim2.new(0, 10, 0, 0)
	botaoSubir.BackgroundColor3 = plataformaAtiva and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 170, 255)
	botaoSubir.Text = plataformaAtiva and "⬇️ Descer" or "⬆️ Subir"
	botaoSubir.Font = Enum.Font.GothamSemibold
	botaoSubir.TextSize = 20
	botaoSubir.TextColor3 = Color3.new(1, 1, 1)
	botaoSubir.Parent = painel

	local round = Instance.new("UICorner")
	round.CornerRadius = UDim.new(0, 10)
	round.Parent = botaoSubir

	botaoSubir.MouseButton1Click:Connect(function()
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")

		if not plataformaAtiva then
			plataforma = Instance.new("Part")
			plataforma.Size = Vector3.new(300, 1, 300) -- área bem grande
			plataforma.Anchored = true
			plataforma.Transparency = 1
			plataforma.CanCollide = true
			plataforma.Position = Vector3.new(root.Position.X, 85, root.Position.Z)
			plataforma.Name = "PlataformaAerea"
			plataforma.Parent = workspace

			task.wait(0.2)
			root.CFrame = CFrame.new(plataforma.Position + Vector3.new(0, 4, 0))
			plataformaAtiva = true
		else
			if plataforma then
				plataforma:Destroy()
			end
			character:MoveTo(Vector3.new(0, 5, 0))
			plataformaAtiva = false
		end

		atualizarBotaoSubir()
	end)
end

atualizarBotaoSubir()

-- Speed Hack contínuo
local speedAtivo = false
criarBotao("🏃‍♂️ Speed Hack", Color3.fromRGB(0, 200, 0), function()
	speedAtivo = not speedAtivo
	if speedAtivo then
		spawn(function()
			while speedAtivo do
				local char = player.Character or player.CharacterAdded:Wait()
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then hum.WalkSpeed = 100 end
				task.wait(0.2)
			end
		end)
	end
end)

-- Super Pulo contínuo
local puloAtivo = false
criarBotao("🦘 Super Pulo", Color3.fromRGB(255, 85, 0), function()
	puloAtivo = not puloAtivo
	if puloAtivo then
		spawn(function()
			while puloAtivo do
				local char = player.Character or player.CharacterAdded:Wait()
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then hum.JumpPower = 150 end
				task.wait(0.2)
			end
		end)
	end
end)



		
