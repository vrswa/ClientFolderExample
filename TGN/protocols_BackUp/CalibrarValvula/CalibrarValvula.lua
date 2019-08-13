CalibrarValvula = {}

CalibrarValvula.index = ser_json_r(FileTool.GetFileAsString("TGN/Protocols/CalibrarValvula/Index.Json"))

CalibrarValvula.New = function() --U: Funcion q uso para crear una nueva 'mission'
    newState = {}
    myIP = "001"
    protocolId = "CalibrarValvula"
    newState["missionId"] = myIP .. "_" .. protocolId .. "_" .. DateTime()
    newState["protocolId"] = "CalibrarValvula"
    newState["header"] = "Calibrar Valvula"
    newState["description"] = "En esta mision hay que calibrar un valvula"
    newState["status"] = "Sin Iniciar"
    newState["meta"] = DateTime()

    path = "TGN/Protocols/CalibrarValvula/Missions/" .. newState["missionId"]
    FileTool.EnsureDir(path)
    FileTool.SetFile(path .. "/State.Json", ser_json(newState))

    return newState
end

CalibrarValvula.Run = function(state)
    local path = "TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/Form.Json"
    local form = FileTool.GetFileAsString(path)
    if form != nil then
      CalibrarValvula.Main(state)
    else
      CalibrarValvula.Form(state)
    end --U: Funcion q uso para ejecutar una 'mission'
end

CalibrarValvula.Main = function(state) --U: Pantalla Principal de la mission
    CleanCanvas("")
    CleanCanvas("Main")

    Cmp({  --A: Grabar un audio
      type = "button",
      title = "Grabar un audio",
      pos = {SCR_W / 16, SCR_H * 0.6, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function()
        CleanCanvas("")
        CleanCanvas("Main")
        CalibrarValvula.RecordAudio(state)
      end,
    })

    Cmp({ --A: Ver foto
      type = "button",
      title = "Ver foto",
      pos = {SCR_W / 16, SCR_H * 0.45, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function() CalibrarValvula.ShowPic(state) end,
    })

    Cmp({ --A: Scanear QR
      type = "button",
      title = "Scanear QR",
      pos = {SCR_W / 16, SCR_H * 0.3, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick =  function() CalibrarValvula.ScanQR(state, CalibrarValvula.Main) end,
    })

    Cmp({  --A: Ver PDF
      type = "button",
      title = "Ver PDF",
      pos = {SCR_W / 16 + SCR_W / 2, SCR_H * 0.6, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function()
        CleanCanvas("")
        CleanCanvas("Main")
        CalibrarValvula.ReadPDF(state)
      end,
    })

    Cmp({  --A: Sacar foto
      type = "button",
      title = "Sacar foto",
      pos = {SCR_W / 16 + SCR_W / 2, SCR_H * 0.45, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function()
        CleanCanvas("")
        CleanCanvas("Main")
        CalibrarValvula.TakePic(state)
      end,
    })

    Cmp({  --A: Grabar video
      type = "button",
      title = "Grabar video",
      pos = {SCR_W / 16 + SCR_W / 2, SCR_H * 0.3, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function()
        CleanCanvas("")
        CleanCanvas("Main")
        --GrabarUnAudio(CalibrarValvula.Main)
      end,
    })

    Cmp({ --A: Volver
      type = "button",
      title = "Volver",
      pos = {SCR_W / 2 - SCR_W/6, SCR_H * 0.1, 0},
      fontSize = 50,
      align = "center",
      width = SCR_W/3,
      height = SCR_H * 0.1,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = function() MissionsMenu2(state) end,
    })
end

CalibrarValvula.RecordAudio = function(state)
  CleanCanvas("Main")
  CleanCanvas("")
  path = "TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/" .. "AudioRecord.wav"
  GrabarUnAudio(path, function() CalibrarValvula.Main(state) end)
end

CalibrarValvula.ShowPic = function(state)
  CleanCanvas("Main")
  CleanCanvas("")

  Cmp({
    type = "label",
    title = "Diagrama de la valvula",
    pos = {1920/4, 800, 0},
    align = "center",
    fontSize = 80,
    width = 1920/2,
    height = 120,
    textCol = {1,1,1},
    imgCol = {0,0,0,0},
    border = false,
    borderCol = {1,1,1},
  })

  Cmp({
        type = "label",
        align = "center",
        imgCol = {1,1,1,1},
        title = "",
        texture = "TGN/Protocols/CalibrarValvula/Valvula.jpg",
        pos = { 1920/2 - 1920/4, 200, 0},
        width = 1920/2, --A: dejamos lugar a la der para botones
        height = 1080/2, --A: dejamos lugar arriba para titulo
    })

  Cmp({
    type = "button",
    title = "OK",
    pos = {1920 - 140, 50, 0},
    align = "center",
    fontSize = 40,
    width = 90,
    height = 90,
    textCol = {1,1,1},
    imgCol = {.4,.4,.4,.5},
    border = true,
    borderCol = {1,1,1},
    onClick = function ()            -- Esta es la funcion que se va a llamar cuando aprete el boton
      CleanCanvas("Main")
      CleanCanvas("")
      CalibrarValvula.Main(state)
    end,
  })
end

CalibrarValvula.Form = function(state)
    CleanCanvas("Main")
    Cmp({
          type = "label",
          title = state.header,
          align = "center",
          fontSize = 60,
          pos = { 1920/2 - 400 , 1080 - 200, 0},
          width = 800, --A: dejamos lugar a la der para botones
          height = 100, --A: dejamos lugar arriba para titulo
          imgCol = {0.8,0.8,0.8, 0}, --A: transparente
          textCol = {1,1,1}, --A: letra blanca
      })

    Cmp({
          type = "label",
          title = "Nombre:",
          align = "left",
          fontSize = 40,
          pos = { 1920/2 - 600, 1080 - 440, 0},
          width = 800, --A: dejamos lugar a la der para botones
          height = 100, --A: dejamos lugar arriba para titulo
          imgCol = {0.8,0.8,0.8, 0}, --A: transparente
          textCol = {1,1,1}, --A: letra blanca
      })

    Cmp({
      id="nombre",
      type="inputField",
      placeholder= "Ingrese su nombre",
      title="",
      pos = { 1920/2 - 600, 1080 - 500, 0},
      width = 1200, --A: dejamos lugar a la der para botones
      height = 100, --A: dejamos lugar arriba para titulo
      imgCol = {1,1,1, 0.4}, --A: transparente
      textCol = {1,1,1}, --A: letra blanca
      id = "Nombre",
    })

    Cmp({
          type = "label",
          title = "Apellido:",
          align = "left",
          fontSize = 40,
          pos = { 1920/2 - 600, 1080 - 640, 0},
          width = 800, --A: dejamos lugar a la der para botones
          height = 100, --A: dejamos lugar arriba para titulo
          imgCol = {0.8,0.8,0.8, 0}, --A: transparente
          textCol = {1,1,1}, --A: letra blanca
      })

    Cmp({
        id="apellido",
        type="inputField",
        placeholder= "Ingrese su apellido",
        title="",
        pos = { 1920/2 - 600, 1080 - 700, 0},
        width = 1200, --A: dejamos lugar a la der para botones
        height = 100, --A: dejamos lugar arriba para titulo
        imgCol = {1,1,1, 0.4}, --A: transparente
        textCol = {1,1,1}, --A: letra blanca
        id = "Apellido",
    });

    Cmp({
          type = "label",
          title = "ID Máquina:",
          align = "left",
          fontSize = 40,
          pos = { 1920/2 - 600, 1080 - 840, 0},
          width = 800, --A: dejamos lugar a la der para botones
          height = 100, --A: dejamos lugar arriba para titulo
          imgCol = {0.8,0.8,0.8, 0}, --A: transparente
          textCol = {1,1,1}, --A: letra blanca
      })

    Cmp({
      id="idMaq",
      type="inputField",
      placeholder= "Ingrese el ID de la maquina",
      title="",
      pos = { 1920/2 - 600, 1080 - 900, 0},
      width = 1200, --A: dejamos lugar a la der para botones
      height = 100, --A: dejamos lugar arriba para titulo
      imgCol = {1,1,1, 0.4}, --A: transparente
      textCol = {1,1,1}, --A: letra blanca
      id = "IdMaquina",
    })


    local onFormSubmit = function()
      CleanCanvas("Main")
      CleanCanvas("")
      --local httpPost = HttpCxMgrData()
      --httpPost.AddField("Nombre", GetValue("Nombre"))
      --httpPost.AddField("Apellido", GetValue("Apellido"))
      --httpPost.AddField("IdMaquina", GetValue("IdMaquina"))
      --HttpCxMgrPost("http://192.168.1.194:8080/api/mission/" .. mission.missionId, httpPost, function(wr)  end, false, {})
      local form = {}
      form["Nombre"] = GetValue("Nombre")
      form["Apellido"] = GetValue("Apellido")
      form["IdMaquina"] = GetValue("IdMaquina")
      FileTool.SetFile("TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/Form.Json", ser_json(form))
      state.header = state.header .. " " .. form["IdMaquina"]
      state.status = "Iniciado"
      FileTool.SetFile("TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/State.Json", ser_json(state))
      CalibrarValvula.Main(state)
    end

    Cmp({
      type = "button",
      title = "OK",
      pos = {1920 - 140, 50, 0},
      align = "center",
      fontSize = 40,
      width = 90,
      height = 90,
      textCol = {1,1,1},
      imgCol = {.4,.4,.4,.5},
      border = true,
      borderCol = {1,1,1},
      onClick = onFormSubmit,
    })  --U: Pantalla del formulario, es obligatorio completarlo antes de avanzar en la mision
end

CalibrarValvula.ScanQR = function(state)
  CleanCanvas("Main")
  CleanCanvas("")

  ScanQR(state, function(QRData)
    FileTool.SetFile("TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/" .. "QRScan.txt", QRData)
    CalibrarValvula.Main(state)
  end)
end

CalibrarValvula.TakePic = function(state)
  CleanCanvas("Main")
  CleanCanvas("")
  SacarUnaFoto("TGN/Protocols/CalibrarValvula/Foto.pdf", CalibrarValvula.Main)
end

CalibrarValvula.ReadPDF = function(state)
  CleanCanvas("Main")
  CleanCanvas("")
  ViewPDF("TGN/Protocols/CalibrarValvula/Ejercicio Mecanizado CNC.pdf", CalibrarValvula.Main)
end
