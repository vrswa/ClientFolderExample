CalibrarValvula = {}

CalibrarValvula.Run = function(state)
    local path = "TGN/Protocols/CalibrarValvula/Missions/" .. state.missionId .. "/Form.Json"
    local form = FileTool.GetFileAsString(path)
    if form != nil then
      CalibrarValvula.Main(state)
    else
      CalibrarValvula.Form(state)
    end
end

CalibrarValvula.Main = function(state)
    Modal("Main")
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
      ScanQR(mission)
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
    })
end

CalibrarValvula.ScanQR = function(state)
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
        ScanQR(mission)
      end,
    })
end
