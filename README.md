# NEOVIM
---

- [Instalacion](#Instalacion)
- [Configuracion](#Configuracion)
- [Comandos](#Comandos)
- [Personalizacion](#Personalizacion)

Bienvenido a las configuraciones de mi *nvim* espero te sean de utilidad!!
El proyecto esta desarrollado en *lua* que es lenguage por el cual se hace posible manipular el funcionamiento de nvim, he configurado nvim de forma que se pueden aprovechar todas sus ventajas, como el poco consumo de memoria, su portatibilidad  y flexibilidad, haciendolo mas eficiente a la hora de programar. Cuenta con todas las funciones basicas que tendria una editor de texto como vscode ( Soporte para una gran variedad de lenguajes,  intregracion de herramientas como git y esilint, alto control sobre el apartado visual, depurador integrado, automatizacion, plugins a la mano ) todo sin compromenter las ventajas antes mencionadas.

## Instalacion 
---

Antes de instalar neovim es es necesario tener herramientas:
- RipGrep: 
- Fish (Linux - Opcional)
- [Configuracion de terminal para window](https://www.youtube.com/watch?v=6SGIFVJ5Izs)
- IosevkaNerdFont
- Chocolatey (Solo si usas window)
- Neovim

Ubuntu/Debian:

```bash
sudo apt install fish
sudo apt install ripgrep 
sudo apt install neovim
```

Arch:

```bash
sudo pacman -S fish
sudo pacman -S ripgrep 
sudo pacman -S neovim
```

Window:

```bash
//Habilitar ejecucion de scripts en la poweshell.
Set-ExecutionPolicy Bypass -Scope Process -Force

//Instalacion de chocolatey.
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

//Verificacion (Si luego de ejcutar el comando te muestra la version significa que esta instalado)
choco

//Luego puedes seguir con el resto de instalaciones.
choco install ripgrep -y
choco install fish -y
choco install neovim -y
```

## Configuracion 
---

Luego de tener las herramientas anteriormente mencionadas se puede proceder a la configuracion de nvim:

Establece fish como terminal predetirminada:

```bash
chsh -s $(which fish)
```

Clonar el repositorio:

```bash
cp -r clone repo jashjasbdakh
```

Mover el directorio descargado al directorio de configuraciones de nvim:

```bash
//Linux
//Si no existe el directorio debe crearse primero.
mkdir -p ~/.config/nvim
mv Desktop/nvim/* ~/.config/nvim

//Window
mv Desktop/nvim/* C:\Users\<TuUsuario>\AppData\Local\nvim

//Ten encuenta que para este ejemplo presupongo que el repositorio fue clonado dentro de Desktop, si lo clonaste en otro directorio debes colocar esa ruta en especifico. 
```

Descargar eslint_d que es una version mas rapida de eslint, utilizaremos esta herramienta para el formateo y la deteccion de errores en el codigo:

```bash
-
npm install -g eslint_d
```

## Comandos
---

Para empezar a usar vim o nvim primero se deben conocer los conceptos y comandos para realizar las funciones mas basicas dentro del editor. Visita la documentacion oficial para conocer los detalles. *[Vim](https://www.vim.org/)* *[Comandos basicos](https://victorhck.gitlab.io/comandos_vim/)*

Explicado los comandos basicos de nvim queda por comentar que estas configuraciones integran plugins que ofrecen distintas funcionalidades extras y por lo consiguinete la mayoria cuentan con sus propios comandos los cuales se detallaran a continuacion:

> **Importante**: Al repasar los comandos ten en cuenta los parametros: 
> "n" significa que el comando es valido en modo normal.
> "gd/gh/gr etc": Es la combinacion de teclas para ejecutar el comando

- Lspconfig: Este plugin permite ver los *Warnig* y *Errores* directamente en el editor como hace vscode. Ademas de ello trae las siguintes funciones que se aplican en clases, funciones, variables y demas:

```bash
("n", "gd") -- Ir a definición
("n", "gh") -- Hover
("n", "gr") -- Referencias
("n", "<leader>rn") -- Renombrar
("n", "<leader>ca") -- Acción de código 
```
    
- Git: Plugin que permite integrar funcionalidades de git:

```bash
<Leader>go = Abre en el navegador el repositorio en el que estas trabjando.
<Leader>gp = Abre el ulltimo pull request del archivo en el que lo ejecutas
<Leader>gn = Abre el navegador directamente para que crees un pull request
<Leader>gr = Te permite regresar tu codigo a versiones anteriores
<Leader>gR = Te permite regresar tu archivo donde corriste el comando a versiones anteriores.
```
     
## Perzonalizacion
---

Para agregar o quitar un keymap perzonalizado en tu nvim puedes hacerlo desde la ruta *lua/config/keymaps.lua*, ahi tambien encontraras algunos keymaps extras que yo mismo he incluido. Para el tema del soporte para diferentes lenguajes dentro de nvim se usan principalmente estos plugins:

 *Lspconfig*: Ya fue explicado antes.
 
 *Mason*: Se usa para instalar los servidores de lenguajes automaticamente sin tener que configurar todo uno mismo.
 
 *MasonLspconfig*: Es un puente para unificar lo que se descarga con Mason y implementarlo en el lspconfig prinicpal.
 
*cmp*: Este se usa para el autocompletado inteligente.

Ejemplo de configuracion de Mason:

```bash
return {
  {
    "williamboman/mason.nvim",              -- Plugin principal de Mason
    dependencies = {
      "williamboman/mason-lspconfig.nvim",   -- Conexión entre Mason y nvim-lspconfig
      "neovim/nvim-lspconfig",               -- Configuración base de LSP
    },
    config = function()
      -- Configuración inicial de Mason
      require("mason").setup()

      -- Configuración de mason-lspconfig
      -- Aqui es donde puedes inidicarle a Mason que servidores de lenguajes instalar. Actualmente nvim tiene soporte para js - ts - lua y python
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright" },  -- Servidores LSP que deseas instalar
      })

      -- Configuración de nvim-lspconfig para servidores específicos
      local lspconfig = require("lspconfig")
      
      -- Las configuraciones manuales son solo si quieres agregar cosas extras demas no es obligatorio escribirlas manualmente.
      
      -- Configuración para el servidor de Lua (lua_ls)
      
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })


    end,
  },
}
```

Al instalar un nuevo servidor de lenguaje debes colocar la configuracion para el cmp en *lua/config/lsp* de esta manera:

```bash

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Usar LuaSnip para snippets
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(), -- Navegar hacia abajo
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navegar hacia arriba
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar selección
    ["<C-Space>"] = cmp.mapping.complete(), -- Forzar autocompletado manual
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- Fuente: LSP
    { name = "luasnip" },  -- Fuente: Snippets
  }, {
    { name = "buffer" },   -- Fuente: Buffer actual
    { name = "path" },     -- Fuente: Rutas
  }),
})

-- Configuración de LSP con nvim-lspconfig. Aqui debes colocar las configuracines de tu nuevo servidor de lenguaje.

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ts_ls.setup({ capabilities = capabilities }) -- JavaScript/TypeScript

lspconfig.lua_ls.setup({ -- Lua
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }, -- Evitar errores con "vim"
    },
  },
})
```

