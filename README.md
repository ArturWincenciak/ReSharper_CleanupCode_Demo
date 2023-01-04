# GitHub Action of ReSharper CLI CleanupCode Demo

# Cleanup your code in local repo

In this repository, you will also find a helper script `local-dev-cleanup-code.sh` that performs an automatic
cleanup and creates a commit on the local repository.

This is an additional feature that allows you to push the commit to the remote repository, avoiding the need to `pull` automatically 
created commit on the remote repository by the GitHub Action. This can save you the hassle of resolving conflicts in case you have made changes 
to the same file locally in the meantime.

## First of all 

Remember to add the required [manifest file](https://github.com/ArturWincenciak/ReSharper_CleanupCode_Demo/blob/main/.config/dotnet-tools.json) 
and then run that commands:

```bash
dotnet tool restore
dotnet tool update --global JetBrains.ReSharper.GlobalTools
source .bashrc
```

## Next time you can just call

```bash
cc
```

