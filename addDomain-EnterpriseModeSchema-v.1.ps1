<# エンタープライズ モード スキーマ v.1 #>

#作業ディレクトリ
Set-Location $HOME\Desktop\

#ファイルの読み込み
$xmlDoc = [XML](Get-Content "サイトリスト.xml")

#バージョンアップ
$xmlDoc.rules.version = [string]([int]$xmlDoc.rules.version + 1)

#ドメインの追記
$element = $xmlDoc.CreateElement("domain")
$element.set_InnerText("example.example")
$element.SetAttribute("exclude","false")
$element.SetAttribute("doNotTransition","true")
$xmlDoc.rules.emie.AppendChild($element)

#ファイルの保存
$dirPath = Get-Location
$xmlDoc.Save("$dirPath\新しいサイトリスト.xml")
