local Players = game:GetService("Players") local RunService = game:GetService("RunService") local player = Players.LocalPlayer local playerGui = player:WaitForChild("PlayerGui")

-- GUI principal local screenGui = Instance.new("ScreenGui", playerGui) screenGui.Name = "MasterHubGui" screenGui.ResetOnSpawn = false

-- Botão flutuante local botaoFlutuante = Instance.new("TextButton") botaoFlutuante.Size = UDim2.new(0, 140, 0, 45) botaoFlutuante.Position = UDim2.new(0, 20, 0.5, -22) botaoFlutuante.BackgroundColor3 = Color3.fromRGB(20, 20, 20) botaoFlutuante.Text = "Master Hub" botaoFlutuante.TextColor3 = Color3.fromRGB(255, 255, 255) botaoFlutuante.Font = Enum.Font.GothamBold botaoFlutuante.TextSize = 22 botaoFlutuante.Parent = screenGui botaoFlutuante.Active = true botaoFlutuante.Draggable = true

local roundFlutuante = Instance.new("UICorner") roundFlutuante.CornerRadius = UDim.new(0, 10) roundFlutuante.Parent = botaoFlutuante

-- Painel local painel = Instance.new("Frame") painel.Size = UDim2.new(0, 240, 0, 220) painel.Position = UDim2.new(0, 180, 0.5, -110) painel.BackgroundColor3 = Color3.fromRGB(35, 35, 35) painel.Visible = false painel.Parent = screenGui

local roundPainel = Instance.new("UICorner") roundPainel.CornerRadius = UDim.new(0, 12) roundPainel.Parent = painel

botaoFlutuante.MouseButton1Click:Connect(function() painel.Visible = not painel.Visible end)

-- Criador de botões local yOffset = 10 local function criarBotao(texto, cor, func) local botao = Instance.new("TextButton") botao.Size = UDim2.new(1, -20, 0, 40) botao.Position = UDim2.new(0, 10, 0, yOffset) yOffset += 50 botao.BackgroundColor3 = cor botao.Text = texto botao.Font = Enum.Font.GothamSemibold botao.TextSize = 20 botao.TextColor3 = Color3.new(1, 1, 1) botao.Parent = painel

local round = Instance.new("UICorner")
round.CornerRadius = UDim.new(0, 10)
round.Parent = botao

botao.MouseButton1Click:Connect(func)

end

-- Função para detectar a base onde o jogador está local function detectarBaseAtual() for _, model in ipairs(workspace:GetChildren()) do if model:IsA("Model") and model:FindFirstChild("Sua Base") then if (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then local dist = (model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart", true)).Position - player.Character.HumanoidRootPart.Position if dist.Magnitude < 60 then return model:FindFirstChild("Sua Base") end end end end return nil end

-- Teleporte para cima da base criarBotao("⬆️ Subir", Color3.fromRGB(0, 170, 255), function() local base = detectarBaseAtual() if base then local cframe = base:GetBoundingBox() local altura = cframe.Position.Y + (cframe.Size.Y / 2) + 10 local novaPos = Vector3.new(cframe.Position.X, altura, cframe.Position.Z)

local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(novaPos)
else
    warn("Base não encontrada")
end

end)

-- Speed Hack 250 local speedAtivo = false criarBotao("🏃‍♂️ Speed Hack", Color3.fromRGB(0, 200, 0), function() speedAtivo = not speedAtivo end)

RunService.RenderStepped:Connect(function() if speedAtivo and player.Character then local hum = player.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 250 end end end)

-- Super Pulo local puloAtivo = false criarBotao("🦘 Super Pulo", Color3.fromRGB(255, 85, 0), function() puloAtivo = not puloAtivo end)

RunService.RenderStepped:Connect(function() if puloAtivo and player.Character then local hum = player.Character:FindFirstChildOfClass("Humanoid") if hum then hum.UseJumpPower = false hum.JumpHeight = 20 end end end)






		
