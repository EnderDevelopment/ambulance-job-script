# Ambulance Job Script

A comprehensive FiveM script for ambulance jobs with revive functionality and cooldowns.

## Features

- Revive functionality for players with a cooldown system
- Cost for reviving players to encourage realism
- Integration with ESX_LEGACY framework for job management

## Requirements

- FiveM server with ESX_LEGACY framework installed
- MySQL database

## Installation

1. Download the script and place it in your FiveM server's `resources` folder.
2. Add `start AmbulanceSystem` to your server.cfg file.
3. Import the `database.sql` file into your MySQL database.

## Usage

- Players with the ambulance job can revive dead players by approaching them and pressing the interact button.
- Each revive has a cooldown and a cost to encourage realism.

## Configuration

The script can be configured in the `config.lua` file. You can adjust the revive cost, cooldown, and other settings to fit your server's needs.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=ambulance-job-script&utm_content=bottom) — describe it in one sentence and get the full source code.