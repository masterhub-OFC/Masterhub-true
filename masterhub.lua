local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MasterHubGui"
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

local roundFlutuante = Instance.new("UICorner")
roundFlutuante.CornerRadius = UDim.new(0, 10)
roundFlutuante.Parent = botaoFlutuante

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
painel.BorderSizePixel = 0
painel.ClipsDescendants = true
painel.AnchorPoint = Vector2.new(0, 0.5)

local roundPainel = Instance.new("UICorner")
roundPainel.CornerRadius = UDim.new(0, 15)
roundPainel.Parent = painel

local sombraPainel = Instance.new("ImageLabel")
sombraPainel.Size = UDim2.new(1, 20, 1, 20)
sombraPainel.Position = UDim2.new(0, -10, 0, -10)
sombraPainel.BackgroundTransparency = 1
sombraPainel.Image = "rbxassetid://1316045217"
sombraPainel.ImageColor3 = Color3.new(0, 0, 0)
sombraPainel.ImageTransparency = 0.6
sombraPainel.Parent = painel
sombraPainel.ZIndex = 0

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 50)
titulo.BackgroundTransparency = 1
titulo.Text = "Master Hub"
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 26
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Parent = painel
titulo.ZIndex = 1

local function criarBotao(texto, posY)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0, 200, 0, 50)
    botao.Position = UDim2.new(0, 20, 0, posY)
    botao.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    botao.TextColor3 = Color3.fromRGB(230, 230, 230)
    botao.Text = texto
    botao.Font = Enum.Font.GothamSemibold
    botao.TextSize = 22
    botao.Parent = painel
    botao.AutoButtonColor = false
    botao.ZIndex = 1

    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, 10)
    round.Parent = botao

    botao.MouseEnter:Connect(function()
        botao.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    botao.MouseLeave:Connect(function()
        botao.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    return botao
end

-- Criar botões
local botaoSubir = criarBotao("⬆️ subir", 70)
local botaoSpeed = criarBotao("Speed Hack", 140)
local botaoPulo = criarBotao("Super Pulo", 210)

-- Funções
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local alturaTerceiroAndar = 50
local alturaExtra = 10

local function subirTelhado()
    local posAtual = rootPart.Position
    local novaPos = Vector3.new(posAtual.X, alturaTerceiroAndar + alturaExtra, posAtual.Z)
    rootPart.CFrame = CFrame.new(novaPos)
end

local speedAtivo = false
local velocidadeNormal = humanoid.WalkSpeed
local velocidadeHack = 100

botaoSubir.MouseButton1Click:Connect(function()
    subirTelhado()
end)

botaoSpeed.MouseButton1Click:Connect(function()
    speedAtivo = not speedAtivo
    if speedAtivo then
        humanoid.WalkSpeed = velocidadeHack
        botaoSpeed.Text = "Speed Hack (ON)"
    else
        humanoid.WalkSpeed = velocidadeNormal
        botaoSpeed.Text = "Speed Hack"
    end
end)

local alturaPulo = alturaTerceiroAndar + alturaExtra
local forcaPulo = alturaPulo * 3

botaoPulo.MouseButton1Click:Connect(function()
    humanoid.JumpPower = forcaPulo
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(3)
    humanoid.JumpPower = 50
end)

-- Animação para abrir/fechar painel
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

botaoFlutuante.MouseButton1Click:Connect(function()
    if painel.Visible then
        local tween = TweenService:Create(painel, tweenInfo, {Size = UDim2.new(0, 240, 0, 0)})
        tween:Play()
        tween.Completed:Wait()
        painel.Visible = false
        painel.Size = UDim2.new(0, 240, 0, 320)
    else
        painel.Visible = true
        painel.Size = UDim2.new(0, 240, 0, 0)
        local tween = TweenService:Create(painel, tweenInfo, {Size = UDim2.new(0, 240, 0, 320)})
        tween:Play()
    end
end)
