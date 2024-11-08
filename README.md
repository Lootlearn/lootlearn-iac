## Project directories and configuration
* Changes to the networking can be made in the [Network module configuration](iac-code/network_module)
* Variable with ```type=sensitive``` are secured in [HCP Terraform cloud](https://app.terraform.io/session)
* Variables used by [script/template](iac-code/scripts/user_data.tpl) and [docker-compose.yml](iac-code/scripts/docker-compose.yml) 
are piped from the cloud resource to the template files. 
To use a dynamic variable in the script, add a value to ```user_data``` and
can be used in the template
    ```yaml
    user_data = templatefile("./scripts/user_data.tpl", {
      mongo_username     = var.mongo_username
    }
    ```
## Media Server Agent configuration

To accommodate the need to add configuration to agents, you will have to bind mount the configuration file e.g; ```service/*.toml``` with ```ro```
permission.
For example, to add environment variables to the Audio agent,
```yaml
audio_agent/agent.toml
```
Modify ```web-rtc-server``` [container service](iac-code/scripts/docker-compose.yml) to use the mounted configuration file.
```yaml
web-rtc-server:
  image: vicdonxp/loot-learn-local-v1
  volumes:
    ...
    - ${XDG_CONFIG_HOME:-$HOME/.config}/owt/audio_agent/agent.toml:/home/owt/audio_agent/agent.toml:ro
 ```
Each of the configuration file can be found in [Open source Project](https://github.com/open-webrtc-toolkit/owt-server/tree/master/source)
