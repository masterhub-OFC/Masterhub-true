local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MasterHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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

-- Canto arredondado botão
local roundFlutuante = Instance.new("UICorner")
roundFlutuante.CornerRadius = UDim.new(0, 10)
roundFlutuante.Parent = botaoFlutuante

-- Sombra no botão
local sombra = Instance.new("ImageLabel")
sombra.Size = UDim2.new(1, 10, 1, 10)
sombra.Position = UDim2.new(0, -5, 0, -5)
sombra.BackgroundTransparency = 1
sombra.Image = "rbxassetid://1316045217"
sombra.ImageColor3 = Color3.new(0, 0, 0)
sombra.ImageTransparency = 0.5
sombra.Parent = botaoFlutuante
sombra.ZIndex = 0

-- Painel principal
local painel = Instance.new("Frame")
painel.Size = UDim2.new(0, 240, 0, 320)
painel.Position = UDim2.new(0, 180, 0.5, -160)
painel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
painel.Visible = false
painel.Parent = screenGui

local roundPainel = Instance.new("UICorner")
roundPainel.CornerRadius = UDim.new(0, 12)
roundPainel.Parent = painel

-- Função: mostrar/esconder painel
botaoFlutuante.MouseButton1Click:Connect(function()
	painel.Visible = not painel.Visible
end)

-- Função criar botão no painel
local function criarBotao(texto, cor, func)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(1, -20, 0, 40)
	botao.Position = UDim2.new(0, 10, 0, #painel:GetChildren() * 45)
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

-- Botão 1: Subir no telhado
criarBotao("⬆️ Subir", Color3.fromRGB(0, 170, 255), function()
	player.Character:MoveTo(Vector3.new(0, 100, 0)) -- Teleporta para cima
end)

-- Botão 2: Speed Hack
criarBotao("🏃‍♂️ Speed Hack", Color3.fromRGB(0, 200, 0), function()
	player.Character.Humanoid.WalkSpeed = 100
end)

-- Botão 3: Super Pulo
criarBotao("🦘 Super Pulo", Color3.fromRGB(255, 85, 0), function()
	player.Character.Humanoid.JumpPower = 150
end)





