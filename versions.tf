# バージョン設定
terraform {
  #　このプロジェクトで使用するTerraform本体のバージョンを指定
  required_version = ">=1.13.0"

  #　AWS　Provider の設定
  required_providers {
    aws = {
      # Providerのダウンロード先を記載
      source = "hashicorp/aws"
      # AWS Providerのバージョンを指定
      version = "~>6.0"
    }
  }
}