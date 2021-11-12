function DownloadAll($platform) {
  $win = Import-Csv "./$platform.csv"

  rm ./staging, ./outputs -r -ErrorAction Ignore
  mkdir ./staging, ./outputs/bin, ./outputs/support -Force
  pushd ./staging

  $win | % {
    Write-Host 'Downloading releases...'
    curl.exe $_.Url -OL

    $toolName = $_.Name
    $filename = $_.Url | Split-Path -Leaf
    $dirName = (gi $filename).BaseName
    mkdir $dirname

    if ([IO.Path]::GetExtension($filename) -in '.zip', '.gz') {
      tar -xf $filename -C $dirName
    }
    else {
      mv $filename $dirName
    }

    $filesPath = Join-Path $dirName ($_.topLevel -eq 1 ? '' : $dirName)
    cp (Join-Path $filesPath $_.bin) ../outputs/bin/$toolName.exe
    mkdir (Join-Path ../outputs/support $toolName)
    gci $filesPath -r | ? Name -In (($_.support ?? '').Split(';').Trim()) | % {
      cp $_ (Join-Path ../outputs/support $toolName $_.Name)
    }
    gci
  }

  popd
}

function CopyOutputs {
  pushd $PSScriptRoot
  cp ./outputs/* ./modern-unix-win/ -r -Force
  cp ../resources/* ../modern-unix-win/support/ -r -Force
}

# DownloadAll 'win'
