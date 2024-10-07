# Quick Minecraft Server Setup (QMSS)
QMSS allows you to easily set up any kind of minecraft server. After inputting some details, [mrpack](https://github.com/nothub/mrpack-install) handles the server download and some of the setup.

## **Install**

Using ubuntu as your server (or any debian based distro), you can install QMSS with one command.

```
wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/create.sh && sudo chmod +x create.sh && ./create.sh
```

## **Todo**
- [X] Add all server types (vanilla, forge, fabric, quilt, neoforge, paper)
- [ ] Add bungeecord/waterfall/velocity support
- [ ] Add tunnel support (cloudflared/playit.gg/any other tunnel software)
- [ ] Add modpack support (Modrinth)
- [ ] Add auto setup feature for all server types
- [ ] Implement premade modpacks
- [ ] Develop web panel